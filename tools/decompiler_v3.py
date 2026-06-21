"""
Battle Brothers Bytecode Decompiler v3
Uses CORRECT Squirrel 3.0.4 opcode table from sqopcodes.h/sqvm.cpp
"""
import json
import struct
import sys
import os
from collections import defaultdict

# CORRECT opcode table from sqopcodes.h
OP_LINE = 0
OP_LOAD = 1
OP_LOADINT = 2
OP_LOADFLOAT = 3
OP_DLOAD = 4
OP_TAILCALL = 5
OP_CALL = 6
OP_PREPCALL = 7
OP_PREPCALLK = 8
OP_GETK = 9
OP_MOVE = 0x0A
OP_NEWSLOT = 0x0B
OP_DELETE = 0x0C
OP_SET = 0x0D
OP_GET = 0x0E
OP_EQ = 0x0F
OP_NE = 0x10
OP_ADD = 0x11
OP_SUB = 0x12
OP_MUL = 0x13
OP_DIV = 0x14
OP_MOD = 0x15
OP_BITW = 0x16
OP_RETURN = 0x17
OP_LOADNULLS = 0x18
OP_LOADROOT = 0x19
OP_LOADBOOL = 0x1A
OP_DMOVE = 0x1B
OP_JMP = 0x1C
OP_JCMP = 0x1D
OP_JZ = 0x1E
OP_SETOUTER = 0x1F
OP_GETOUTER = 0x20
OP_NEWOBJ = 0x21
OP_APPENDARRAY = 0x22
OP_COMPARITH = 0x23
OP_INC = 0x24
OP_INCL = 0x25
OP_PINC = 0x26
OP_PINCL = 0x27
OP_CMP = 0x28
OP_EXISTS = 0x29
OP_INSTANCEOF = 0x2A
OP_DELEGATE = 0x2A  # Same as INSTANCEOF in some Squirrel versions
OP_AND = 0x2B
OP_OR = 0x2C
OP_NEG = 0x2D
OP_NOT = 0x2E
OP_BWNOT = 0x2F
OP_CLOSURE = 0x30
OP_YIELD = 0x31
OP_RESUME = 0x32
OP_FOREACH = 0x33
OP_POSTFOREACH = 0x34
OP_CLONE = 0x35
OP_TYPEOF = 0x36
OP_PUSHTRAP = 0x37
OP_POPTRAP = 0x38
OP_THROW = 0x39
OP_NEWSLOTA = 0x3A
OP_GETBASE = 0x3B
OP_CLOSE = 0x3C

# BitWiseOP sub-opcodes
BW_AND = 0
BW_OR = 2
BW_XOR = 3
BW_SHIFTL = 4
BW_SHIFTR = 5
BW_USHIFTR = 6

# CmpOP sub-opcodes
CMP_G = 0
CMP_GE = 2
CMP_L = 3
CMP_LE = 4
CMP_3W = 5

# NewObjectType
NOT_TABLE = 0
NOT_ARRAY = 1
NOT_CLASS = 2

# AppendArrayType
AAT_STACK = 0
AAT_LITERAL = 1
AAT_INT = 2
AAT_FLOAT = 3
AAT_BOOL = 4


def signed32(x):
    """Convert unsigned 32-bit to signed 32-bit."""
    if x >= 0x80000000:
        return x - 0x100000000
    return x


class Decompiler:
    def __init__(self, func_info):
        self.source = func_info.get('source', '<unknown>')
        self.name = func_info.get('name', '<anonymous>')
        self.ninst = func_info.get('ninstructions', 0)
        self.stacksize = func_info.get('stacksize', 0)
        self.literals = func_info.get('literals', [])
        self.parameters = func_info.get('parameters', [])
        self.inst_hex = func_info.get('instructions', '')
        self.nfunctions = func_info.get('nfunctions', 0)

        self.instructions = []
        self.output_lines = []
        self.indent_level = 1
        self.reg_values = {}  # reg -> (type, value) tuple
        self.line_num = 0
        self.func_name = self.name or '<anonymous>'
        self.label_counter = 0
        self.pending_labels = {}  # ip -> label_name
        self.referenced_labels = set()  # label names actually used in goto statements
        self.prepared_obj_reg = None
        self.prepcall_obj_map = {}
        self.pending_array_reg = None
        self.pending_array_items = []
        self.pending_table_reg = None
        self.pending_table_items = {}

        # Control flow analysis state
        self.cf_blocks = {}  # ip -> {type, ...} for opening blocks
        self.cf_exits = {}  # exit_ip -> [list of {entry_ip, type, ...}]
        self.cf_instructions = set()  # IPs of instructions that are part of control flow
        self.block_stack = []  # [{entry_ip, type, exit_ip, ...}]
        self.silent_ips = set()  # IPs of compound chain instructions (process reg_values but no output)
        self.compound_chain_terminators = {}  # ip -> {'conditions': [...], 'op': OP_AND/OR}
        self.guard_blocks = {}  # start_ip -> {'source_ip': ip, 'chain_op': OP_AND/OR, 'end_ip': ip}
        self._current_ip = -1  # Currently processing instruction IP

    def parse_instructions(self):
        inst_bytes = bytes.fromhex(self.inst_hex) if self.inst_hex else b''
        for i in range(self.ninst):
            off = i * 8
            if off + 8 > len(inst_bytes):
                break
            arg1 = struct.unpack_from('<I', inst_bytes, off)[0]
            op = inst_bytes[off + 4]
            arg0 = inst_bytes[off + 5]
            arg2 = inst_bytes[off + 6]
            arg3 = inst_bytes[off + 7]
            self.instructions.append({
                'ip': i, 'op': op, 'arg0': arg0,
                'arg1': arg1, 'arg2': arg2, 'arg3': arg3
            })

    def get_literal(self, idx):
        if 0 <= idx < len(self.literals):
            return self.literals[idx]
        return f'k[{idx}]'

    def lit_str(self, idx):
        """Return literal as a quoted string"""
        return f'"{self.get_literal(idx)}"'

    def set_reg(self, r, val):
        if isinstance(val, str):
            val = ('expr', val)
        self.reg_values[r] = val

    def get_reg(self, r):
        v = self.reg_values.get(r)
        if v is None:
            return f'r{r}'
        typ, data = v
        if typ == 'str':
            return f'"{data}"'
        elif typ == 'int':
            return str(data)
        elif typ == 'float':
            return str(data)
        elif typ == 'bool':
            return 'true' if data else 'false'
        elif typ == 'null':
            return 'null'
        else:
            return str(data)

    def get_raw(self, r):
        v = self.reg_values.get(r)
        if v is None:
            return f'r{r}'
        typ, data = v
        if typ == 'str':
            return str(data)
        elif typ == 'expr':
            return str(data)
        else:
            return str(data)

    def indent(self):
        return '    ' * self.indent_level

    def emit(self, line):
        if self._current_ip in self.silent_ips:
            return
        self.output_lines.append(self.indent() + line)

    def emit_raw(self, line):
        self.output_lines.append(line)

    def format_property_access(self, obj, prop):
        if prop and prop[0].isalpha() and prop.replace('_', '').isalnum():
            return f'{obj}.{prop}'
        else:
            return f'{obj}["{prop}"]'

    def is_jump_op(self, op):
        return op in (OP_JMP, OP_JZ, OP_JCMP, OP_AND, OP_OR)

    def get_jump_target(self, inst):
        """Get the absolute target IP of a jump instruction."""
        if self.is_jump_op(inst['op']):
            return inst['ip'] + 1 + signed32(inst['arg1'])
        return None

    def build_compound_chains(self):
        """Detect AND/OR chains: consecutive AND/OR (with conditions between) targeting the same exit.
        Two patterns:
          1. AND chain → JZ: guard clauses  `if (a && b && c) { ... }`
          2. OR chain  → RETURN: compound return  `return (a || b || c);`
        Between AND/OR there are condition-building instructions (NE, GETK, LOADNULLS, etc.)
        and MOVE instructions at the end to shuffle registers.
        """
        if not self.instructions:
            return

        ninst = len(self.instructions)
        i = 0
        while i < ninst:
            inst = self.instructions[i]
            if inst['op'] not in (OP_AND, OP_OR):
                i += 1
                continue

            chain_op = inst['op']  # OP_AND or OP_OR
            chain = []  # list of {'ip', 'cond_reg'}
            chain_ips = set()  # all IPs in the chain
            j = i

            # Collect AND/OR with any instructions between them (except LINE)
            while j < ninst:
                jinst = self.instructions[j]
                if jinst['op'] == chain_op:
                    chain.append({'ip': j, 'cond_reg': jinst['arg0']})
                    chain_ips.add(j)
                    j += 1
                elif jinst['op'] == OP_MOVE and len(chain) > 0:
                    # MOVE at end of chain (register shuffling before terminator)
                    chain_ips.add(j)
                    j += 1
                elif jinst['op'] == OP_LINE:
                    # LINE separates chain from next section; stop
                    break
                elif jinst['op'] in (OP_JZ, OP_RETURN):
                    # Terminator reached
                    break
                elif len(chain) == 0:
                    # No AND/OR found yet; this is a pre-chain instruction, skip past
                    break
                else:
                    # Condition-building instructions between AND/OR (NE, GETK, etc.)
                    # These must be processed normally (update reg_values + emit output)
                    j += 1

            # Need at least 2 AND/OR for a compound chain
            if len(chain) < 2:
                i += 1
                continue

            # Check if terminated by JZ (AND guard), RETURN (OR return), or non-CF (guard block)
            if j >= ninst:
                i += 1
                continue
            term = self.instructions[j]
            if term['op'] in (OP_JZ, OP_RETURN):
                # Valid compound chain terminated by JZ or RETURN
                chain_ips.add(j)
                self.silent_ips.update(chain_ips)
                self.compound_chain_terminators[j] = {
                    'chain_op': chain_op,
                    'conditions': chain,
                }
                i = j + 1
            elif term['op'] not in (OP_AND, OP_OR, OP_JMP):
                # Multi-AND/OR chain terminated by non-CF instruction (guard block)
                chain_ips.add(j)
                self.silent_ips.update(chain_ips)
                guard_start = j
                guard_end = j
                k = j + 1
                while k < ninst:
                    kinst = self.instructions[k]
                    if kinst['op'] in (OP_JZ, OP_JCMP, OP_JMP, OP_RETURN, OP_AND, OP_OR,
                                       OP_FOREACH, OP_POSTFOREACH, OP_PUSHTRAP, OP_THROW):
                        if kinst['op'] in (OP_JZ, OP_JCMP):
                            guard_end = kinst['ip'] + 1 + signed32(kinst['arg1'])
                        elif kinst['op'] == OP_FOREACH and kinst['ip'] in self.cf_blocks:
                            foreach_info = self.cf_blocks[kinst['ip']]
                            if foreach_info.get('back_ip'):
                                guard_end = foreach_info['back_ip'] + 1
                            else:
                                guard_end = k
                        else:
                            guard_end = k
                        break
                    if k not in self.cf_instructions:
                        self.silent_ips.add(k)
                    guard_end = k + 1
                    k += 1
                if guard_start not in self.guard_blocks:
                    self.guard_blocks[guard_start] = {
                        'source_ip': chain[0]['ip'],
                        'chain_op': chain_op,
                        'end_ip': guard_end,
                    }
                i = j + 1
            else:
                i += 1
                continue

        # Additional pass: detect single AND/OR → JZ/RETURN patterns
        for inst in self.instructions:
            if inst['op'] not in (OP_AND, OP_OR):
                continue
            and_ip = inst['ip']
            and_target = and_ip + 1 + signed32(inst['arg1'])
            # Already part of a compound chain?
            if and_ip in self.silent_ips:
                continue
            # Check if AND targets a JZ instruction (guard clause pattern)
            # OR check if AND targets a RETURN (compound return pattern)
            if and_target >= ninst or and_target <= and_ip:
                continue
            target_inst = self.instructions[and_target]
            if target_inst['op'] == OP_JZ:
                # Single AND→JZ compound guard
                chain_ips2 = set(range(and_ip, and_target + 1))
                self.silent_ips.update(chain_ips2)
                self.compound_chain_terminators[and_target] = {
                    'chain_op': OP_AND,
                    'conditions': [
                        {'ip': and_ip, 'cond_reg': inst['arg0']},
                        {'ip': and_target, 'cond_reg': target_inst['arg0']},
                    ],
                }
            elif target_inst['op'] == OP_RETURN and inst['op'] == OP_AND:
                # Single AND→RETURN: compound return
                chain_ips2 = set(range(and_ip, and_target + 1))
                self.silent_ips.update(chain_ips2)
                self.compound_chain_terminators[and_target] = {
                    'chain_op': OP_AND,
                    'conditions': [
                        {'ip': and_ip, 'cond_reg': inst['arg0']},
                        {'ip': and_target, 'cond_reg': target_inst['arg0']},
                    ],
                }
            elif target_inst['op'] == OP_RETURN and inst['op'] == OP_OR:
                # Single OR→RETURN: compound return
                chain_ips2 = set(range(and_ip, and_target + 1))
                self.silent_ips.update(chain_ips2)
                self.compound_chain_terminators[and_target] = {
                    'chain_op': OP_OR,
                    'conditions': [
                        {'ip': and_ip, 'cond_reg': inst['arg0']},
                        {'ip': and_target, 'cond_reg': target_inst['arg0']},
                    ],
                }

        # Pass 3: detect single AND/OR targeting non-JZ/RETURN instructions (guard blocks)
        for inst in self.instructions:
            if inst['op'] not in (OP_AND, OP_OR):
                continue
            and_ip = inst['ip']
            and_target = and_ip + 1 + signed32(inst['arg1'])
            # Already handled by compound chains?
            if and_ip in self.silent_ips:
                continue
            if and_target >= ninst or and_target <= and_ip:
                continue
            target_inst = self.instructions[and_target]
            # Skip JMP targets (already handled)
            if target_inst['op'] == OP_JMP:
                continue
            # Skip JZ, RETURN targets (already handled by pass 2)
            if target_inst['op'] in (OP_JZ, OP_RETURN):
                continue
            # For AND/OR targets: only handle if target is in a guard block range
            if target_inst['op'] in (OP_AND, OP_OR):
                # Check if target is inside an existing guard block range
                target_in_guard = False
                for gb_start, gb_info in self.guard_blocks.items():
                    if gb_start <= and_target < gb_info['end_ip']:
                        target_in_guard = True
                        break
                if not target_in_guard:
                    continue
                # Fall through to add condition to existing guard block
            # AND/OR targets a non-CF instruction: create guard block
            self.silent_ips.add(and_ip)
            guard_start = and_target
            # Skip if target is a compound chain terminator (would create conflicting if-blocks)
            if guard_start in self.compound_chain_terminators:
                continue
            guard_end = and_target
            k = and_target + 1
            while k < ninst:
                kinst = self.instructions[k]
                if kinst['op'] in (OP_JZ, OP_JCMP, OP_JMP, OP_RETURN, OP_AND, OP_OR,
                                   OP_FOREACH, OP_POSTFOREACH, OP_PUSHTRAP, OP_THROW):
                    if kinst['op'] in (OP_JZ, OP_JCMP):
                        guard_end = kinst['ip'] + 1 + signed32(kinst['arg1'])
                    elif kinst['op'] == OP_FOREACH and kinst['ip'] in self.cf_blocks:
                        # Extend guard_end past the foreach loop
                        foreach_info = self.cf_blocks[kinst['ip']]
                        if foreach_info.get('back_ip'):
                            guard_end = foreach_info['back_ip'] + 1
                        else:
                            guard_end = k
                    else:
                        guard_end = k
                    break
                # Don't add cf_instructions to silent_ips
                if k not in self.cf_instructions:
                    self.silent_ips.add(k)
                guard_end = k + 1
                k += 1
            if guard_start not in self.guard_blocks:
                self.guard_blocks[guard_start] = {
                    'source_ip': and_ip,
                    'chain_op': inst['op'],
                    'end_ip': guard_end,
                }
            else:
                # Target already has a guard block (from a later AND/OR).
                # The later AND/OR's condition is more directly related to the
                # guard block. Add the current condition to the guard block's
                # additional conditions list (combined with && in handler).
                existing = self.guard_blocks[guard_start]
                existing.setdefault('extra_conditions', []).append({
                    'ip': and_ip, 'cond_reg': inst['arg0'],
                })

        # Pass 4: follow AND→OR / OR→AND chains to final targets,
        # add extra_conditions to guard blocks at those targets
        for inst in self.instructions:
            if inst['op'] not in (OP_AND, OP_OR):
                continue
            and_ip = inst['ip']
            if and_ip in self.silent_ips:
                continue
            and_target = and_ip + 1 + signed32(inst['arg1'])
            if and_target >= ninst or and_target <= and_ip:
                continue
            target_inst = self.instructions[and_target]
            if target_inst['op'] not in (OP_AND, OP_OR):
                continue
            # Follow AND/OR chain to terminal
            final_target = and_target
            depth = 0
            while depth < 20:
                tinst = self.instructions[final_target]
                if tinst['op'] not in (OP_AND, OP_OR):
                    break
                final_target = final_target + 1 + signed32(tinst['arg1'])
                if final_target >= ninst or final_target <= and_ip:
                    break
                depth += 1
            else:
                continue
            if final_target >= ninst:
                continue
            # Check if final target is in a guard block range
            found_guard = False
            for gb_start, gb_info in self.guard_blocks.items():
                gb_end = gb_info['end_ip']
                src_ip = gb_info.get('source_ip', gb_start)
                if gb_start <= final_target < gb_end:
                    # Final target is inside the guard block body
                    found_guard = True
                elif src_ip < final_target < gb_start:
                    # Final target is in condition code before this guard block
                    # (e.g. AND→OR chain that feeds into the guard block's condition)
                    found_guard = True
                if found_guard:
                    self.silent_ips.add(and_ip)
                    gb_info.setdefault('extra_conditions', []).append({
                        'ip': and_ip, 'cond_reg': inst['arg0'],
                    })
                    break
            if found_guard:
                continue
            # Check if final target is a compound chain terminator (JZ/RETURN)
            if final_target in self.compound_chain_terminators:
                self.silent_ips.add(and_ip)
                chain_info = self.compound_chain_terminators[final_target]
                chain_info['conditions'].insert(0, {
                    'ip': and_ip, 'cond_reg': inst['arg0'],
                })
                continue
            # Check if final target is an AND/OR that's in a compound chain
            # (find the terminator for this chain)
            chain_term = final_target
            for term_ip, term_info in self.compound_chain_terminators.items():
                for c in term_info['conditions']:
                    if c['ip'] == final_target:
                        self.silent_ips.add(and_ip)
                        term_info['conditions'].insert(0, {
                            'ip': and_ip, 'cond_reg': inst['arg0'],
                        })
                        chain_term = None
                        break
                if chain_term is None:
                    break
            if chain_term is None:
                continue
            # Also check if any intermediate AND/OR in the chain is in a compound chain
            mid = and_target
            mid_depth = 0
            while mid_depth < 20 and mid != final_target:
                mid_inst = self.instructions[mid]
                if mid_inst['op'] not in (OP_AND, OP_OR):
                    break
                for term_ip, term_info in self.compound_chain_terminators.items():
                    for c in term_info['conditions']:
                        if c['ip'] == mid:
                            self.silent_ips.add(and_ip)
                            term_info['conditions'].insert(0, {
                                'ip': and_ip, 'cond_reg': inst['arg0'],
                            })
                            mid = None
                            break
                    if mid is None:
                        break
                if mid is None:
                    break
                mid = mid + 1 + signed32(mid_inst['arg1'])
                mid_depth += 1

    def build_control_flow_map(self):
        """Analyze control flow: detect if/else/while/foreach patterns."""
        if not self.instructions:
            return

        cf = {}  # ip -> block info

        # PASS 1: Detect foreach loops
        # Pattern 1: FOREACH ... POSTFOREACH(backward jump to FOREACH)
        # Pattern 2: FOREACH ... POSTFOREACH(no backward) ... JMP(backward to FOREACH)
        foreach_map = {}  # foreach_ip -> postforeach_ip
        foreach_ips = set()
        postforeach_ips = set()
        for inst in self.instructions:
            if inst['op'] == OP_FOREACH:
                foreach_ips.add(inst['ip'])
            if inst['op'] == OP_POSTFOREACH:
                postforeach_ips.add(inst['ip'])

        # Pattern 1: POSTFOREACH with backward jump
        for post_ip in postforeach_ips:
            inst = self.instructions[post_ip]
            target = post_ip + 1 + signed32(inst['arg1'])
            if target < post_ip and target in foreach_ips:
                foreach_map[target] = post_ip
                cf.setdefault(post_ip, {'type': 'foreach_close', 'close_target': target})

        # Pattern 2: backward JMP targeting FOREACH
        for inst in self.instructions:
            if inst['op'] == OP_JMP:
                target = inst['ip'] + 1 + signed32(inst['arg1'])
                if target in foreach_ips and inst['ip'] > target:
                    jmp_ip = inst['ip']
                    # Find the corresponding POSTFOREACH (after FOREACH, before JMP)
                    post_ip = None
                    for p in postforeach_ips:
                        if target < p < jmp_ip:
                            post_ip = p
                            break
                    foreach_map[target] = post_ip if post_ip else jmp_ip
                    cf.setdefault(target, {
                        'type': 'foreach',
                        'back_ip': jmp_ip,
                        'post_ip': post_ip,
                    })
                    cf.setdefault(jmp_ip, {
                        'type': 'foreach_back',
                        'foreach_ip': target,
                    })
                    # Mark FOREACH, POSTFOREACH, and JMP as cf_instructions
                    self.cf_instructions.add(target)
                    if post_ip is not None:
                        self.cf_instructions.add(post_ip)
                    self.cf_instructions.add(jmp_ip)

        # PASS 2: Detect while loops (JZ at L, backward JMP to L)
        for inst in self.instructions:
            if inst['op'] == OP_JMP:
                target = self.get_jump_target(inst)
                if target is not None and target < inst['ip']:
                    # Backward jump - check if target is a JZ (while loop)
                    tinst = self.instructions[target]
                    while_start = None
                    jz_inst = None
                    if tinst['op'] == OP_JZ:
                        # Direct: JMP targets JZ
                        while_start = target
                        jz_inst = tinst
                    elif target + 1 < len(self.instructions):
                        # LOADBOOL + JZ pattern: JMP targets LOADBOOL, next is JZ
                        next_inst = self.instructions[target + 1]
                        if tinst['op'] == OP_LOADBOOL and next_inst['op'] == OP_JZ:
                            while_start = target
                            jz_inst = next_inst
                    if jz_inst is not None:
                        cond = self.get_reg(jz_inst['arg0'])
                        cf.setdefault(while_start, {'type': 'while', 'cond': cond, 'back_ip': inst['ip']})
                        # Store exit info
                        self.cf_exits.setdefault(inst['ip'], []).append({
                            'entry_ip': while_start, 'type': 'while', 'exit_ip': inst['ip']
                        })

        # PASS 3: Build collapse map for else-if chains
        collapse_map = {}  # original_target -> new_exit_ip
        for inst in self.instructions:
            if inst['op'] == OP_JZ:
                target = self.get_jump_target(inst)
                if target is not None and target > inst['ip']:
                    tinst = self.instructions[target]
                    if tinst['ip'] > 0:
                        prev = self.instructions[tinst['ip'] - 1]
                        if prev['op'] == OP_JMP:
                            jmp_exit = self.get_jump_target(prev)
                            # Don't collapse if the JMP exit is a while loop start
                            if jmp_exit in cf and cf[jmp_exit].get('type') == 'while':
                                continue
                            collapse_map[target] = jmp_exit

        # PASS 4: Detect if/else patterns using JZ/JCMP/JMP
        for inst in self.instructions:
            if inst['op'] == OP_JZ:
                target = self.get_jump_target(inst)
                if target is None or target <= inst['ip']:
                    continue
                cond_reg = inst['arg0']
                cond = self.get_reg(cond_reg)
            elif inst['op'] == OP_JCMP:
                target = self.get_jump_target(inst)
                if target is None or target <= inst['ip']:
                    continue
                left = self.get_reg(inst['arg2'])
                right = self.get_reg(inst['arg0'])
                cmp_ops = {CMP_G: '>', CMP_GE: '>=', CMP_L: '<', CMP_LE: '<=', CMP_3W: '<=>'}
                opchar = cmp_ops.get(inst['arg3'], f'cmp{inst["arg3"]}')
                cond = f'({left} {opchar} {right})'
                cond_reg = None
            else:
                continue

            # Check collapse for else-if chains
            exit_ip = target
            is_collapsed = False
            if target in collapse_map:
                # Check if the JMP before the target label is part of an elseif chain
                # by seeing if the next instruction after the JMP also jumps to a collapsed target
                jmp_before_target = self.instructions[target - 1] if target > 0 else None
                if jmp_before_target and jmp_before_target['op'] == OP_JMP:
                    jmp_exit = self.get_jump_target(jmp_before_target)
                    # Check if there's another JZ after this one that also collapses to the same exit
                    has_next_chain = False
                    for future_inst in self.instructions[inst['ip'] + 1:]:
                        if future_inst['op'] == OP_JZ:
                            future_target = self.get_jump_target(future_inst)
                            if future_target in collapse_map and collapse_map[future_target] == jmp_exit:
                                has_next_chain = True
                            break
                    if has_next_chain and jmp_exit is not None:
                        exit_ip = jmp_exit
                        is_collapsed = True

            # Skip if this creates a while loop
            if target in cf and cf[target].get('type') == 'while':
                continue
            # Skip if part of foreach
            if inst['ip'] in foreach_map:
                continue

            cf.setdefault(inst['ip'], {
                'type': 'if',
                'cond': cond,
                'cond_reg': cond_reg,
                'exit_ip': exit_ip,
                'is_collapsed': is_collapsed,
                'original_target': target,
            })
            # Store exit info separately
            exit_info = {'entry_ip': inst['ip'], 'type': 'simple_if', 'exit_ip': exit_ip}
            self.cf_exits.setdefault(exit_ip, []).append(exit_info)

        # PASS 5: Detect compound AND/OR chains
        self.build_compound_chains()

        # Add JZ compound terminators to cf_exits (they create if blocks)
        for term_ip, term_info in self.compound_chain_terminators.items():
            if term_ip < len(self.instructions) and self.instructions[term_ip]['op'] == OP_JZ:
                exit_ip = term_ip + 1 + signed32(self.instructions[term_ip]['arg1'])
                self.cf_exits.setdefault(exit_ip, []).append({
                    'entry_ip': term_ip, 'type': 'simple_if', 'exit_ip': exit_ip
                })

        # PASS 6: Collect all block boundaries
        block_entries = set()
        block_exits = set()
        for ip, info in cf.items():
            block_entries.add(ip)
        for exit_ip, exits in self.cf_exits.items():
            block_exits.add(exit_ip)
            for exit_info in exits:
                block_entries.add(exit_info['entry_ip'])

        all_boundaries = sorted(block_entries | block_exits)
        if all_boundaries:
            self.cf_instructions = set(range(min(all_boundaries), max(all_boundaries) + 1))
            for ip in block_entries:
                self.cf_instructions.add(ip)
        # Compound terminators from multi-condition chains are handled separately
        # But keep JZ terminators that are also if-block headers in cf_blocks
        compound_term_ips = {ip for ip, info in self.compound_chain_terminators.items()
                            if len(info.get('conditions', [])) >= 2 and ip not in cf}
        self.cf_instructions -= compound_term_ips

        self.cf_blocks = cf

    def process_blocks_at_ip(self, ip):
        """Process control flow blocks at instruction pointer ip.
        Returns True if a block was opened at this IP (new if/while/foreach)."""
        opened_block = False

        # CLOSE blocks at their exit IP (using block_stack's exit_ip)
        while self.block_stack and self.block_stack[-1].get('exit_ip') == ip:
            top = self.block_stack[-1]
            if top['type'] in ('simple_if', 'then_else', 'else'):
                self.indent_level -= 1
                self.emit('}')
                self.block_stack.pop()
            elif top['type'] == 'while':
                self.indent_level -= 1
                self.emit('}')
                self.block_stack.pop()
            else:
                break

        # Check for while loops (handled in cf_blocks, cond resolved at analysis time)
        if ip in self.cf_blocks:
            info = self.cf_blocks[ip]
            if info['type'] == 'while':
                cond = info['cond']
                self.emit(f'while ({cond})')
                self.emit('{')
                self.indent_level += 1
                self.block_stack.append({
                    'entry_ip': ip,
                    'type': 'while',
                    'exit_ip': info['back_ip'],
                    'back_ip': info['back_ip'],
                    'open_indent': self.indent_level - 1,
                    'dead_code': False,
                })
                opened_block = True
            elif info['type'] == 'foreach_close':
                # POSTFOREACH: close foreach block
                for i in range(len(self.block_stack) - 1, -1, -1):
                    if self.block_stack[i]['type'] == 'foreach':
                        self.block_stack.pop(i)
                        self.indent_level -= 1
                        self.emit('}')
                        break

        # Process exits at this IP (cf_exits) - handle else conversion
        if ip in self.cf_exits:
            for exit_info in self.cf_exits[ip]:
                entry_ip = exit_info['entry_ip']
                for i in range(len(self.block_stack) - 1, -1, -1):
                    if self.block_stack[i]['entry_ip'] == entry_ip:
                        top = self.block_stack[i]
                        if top['type'] == 'simple_if':
                            inst = self.instructions[ip] if ip < len(self.instructions) else None
                            if inst and inst['op'] == OP_JMP:
                                jmp_target = self.get_jump_target(inst)
                                if jmp_target == top['exit_ip']:
                                    self.indent_level -= 1
                                    self.emit('}')
                                    self.emit('else')
                                    self.emit('{')
                                    self.indent_level += 1
                                    top['type'] = 'else'
                                    if 'original_target' in top:
                                        del top['original_target']
                                    return False
                        break

        # Handle JMP that closes a simple_if block (no else follows)
        if ip < len(self.instructions):
            inst = self.instructions[ip]
            if inst['op'] == OP_JMP and self.block_stack:
                top = self.block_stack[-1]
                if top['type'] == 'simple_if':
                    jmp_target = self.get_jump_target(inst)
                    original_target = top.get('original_target', top['exit_ip'])
                    # Check if JMP targets the block's exit or original target
                    if jmp_target == top['exit_ip'] or jmp_target == original_target:
                        # If exit_ip != original_target, this is a collapsed elseif chain
                        # Convert to else instead of closing
                        if top['exit_ip'] != original_target:
                            self.indent_level -= 1
                            self.emit('}')
                            self.emit('else')
                            self.emit('{')
                            self.indent_level += 1
                            top['type'] = 'else'
                            del top['original_target']
                            return False
                        else:
                            self.indent_level -= 1
                            self.emit('}')
                            self.block_stack.pop()
                            return False
                    else:
                        # NEW: Check if JMP targets a later if-block's exit_ip
                        # This is an if-else pattern: JMP skips the else body to a shared exit
                        for later_ip, later_info in self.cf_blocks.items():
                            if (later_info.get('type') == 'if'
                                    and later_info.get('exit_ip') == jmp_target
                                    and later_ip >= top['exit_ip']):
                                self.indent_level -= 1
                                self.emit('}')
                                self.emit('else')
                                self.emit('{')
                                self.indent_level += 1
                                top['type'] = 'else'
                                top['exit_ip'] = jmp_target
                                return False

        return opened_block

    def is_in_cf_block(self, ip):
        """Check if instruction is inside a control flow block (skip raw output)."""
        return ip in self.cf_instructions

    def invert_condition(self, cond):
        """Invert a condition for if statement (remove double negation)."""
        if cond.startswith('(!') and cond.endswith(')'):
            # Find matching closing paren for the !
            depth = 0
            for i in range(1, len(cond)):
                if cond[i] == '(':
                    depth += 1
                elif cond[i] == ')':
                    depth -= 1
                    if depth == 0:
                        inner = cond[2:i]
                        if i == len(cond) - 1:
                            return inner
                        break
        return f'!({cond})'

    def add_label(self, ip):
        if ip not in self.pending_labels:
            self.pending_labels[ip] = f'__label_{ip}'

    def resolve_labels(self):
        """Pre-scan to find all jump targets, skipping control flow ones."""
        for inst in self.instructions:
            op = inst['op']
            arg1 = signed32(inst['arg1'])
            ip = inst['ip']

            if op == OP_JMP:
                self.add_label(ip + 1 + arg1)
            elif op == OP_JZ:
                self.add_label(ip + 1 + arg1)
            elif op == OP_JCMP:
                self.add_label(ip + 1 + arg1)
            elif op in (OP_AND, OP_OR):
                self.add_label(ip + 1 + arg1)
            elif op == OP_PUSHTRAP:
                self.add_label(ip + 1 + arg1)

        # Remove labels that are handled by control flow analysis
        for ip in self.cf_blocks:
            if ip in self.pending_labels:
                del self.pending_labels[ip]
        for exit_ip in self.cf_exits:
            if exit_ip in self.pending_labels:
                del self.pending_labels[exit_ip]
        # Remove labels at collapsed JZ targets (else-if chains)
        for ip, info in self.cf_blocks.items():
            if info.get('type') == 'if' and info.get('is_collapsed'):
                orig = info.get('original_target')
                if orig and orig in self.pending_labels:
                    del self.pending_labels[orig]
        # Remove labels at guard block targets (handled by guard block if)
        for ip in self.guard_blocks:
            if ip in self.pending_labels:
                del self.pending_labels[ip]

    def post_process(self, text):
        """Clean up the decompiled output."""
        import re
        lines = text.split('\n')

        # Pass 1: Remove dead code labels (label: followed by return;)
        pass1 = []
        for j, line in enumerate(lines):
            stripped = line.strip()
            if stripped.endswith(':') and j + 1 < len(lines):
                next_stripped = lines[j + 1].strip()
                if next_stripped == 'return;':
                    continue
            pass1.append(line)

        # Pass 2: Remove redundant return; after another return statement
        pass2 = []
        for j, line in enumerate(pass1):
            stripped = line.strip()
            if stripped == 'return;':
                is_redundant = False
                for k in range(j - 1, -1, -1):
                    prev = pass1[k].strip()
                    if prev == '' or prev == '}':
                        continue
                    if prev.startswith('return ') and prev.endswith(';'):
                        is_redundant = True
                    break
                if is_redundant:
                    continue
            pass2.append(line)

        # Pass 3: Remove double parentheses: if ((expr)) -> if (expr)
        result = []
        for line in pass2:
            line = re.sub(r'if \(\((.+?)\)\)', r'if (\1)', line)
            result.append(line)

        return '\n'.join(result)

    def decompile(self):
        self.parse_instructions()
        self.build_control_flow_map()
        self.resolve_labels()

        # Function header
        param_str = ', '.join(self.parameters) if self.parameters else 'this'
        self.emit_raw(f'function {self.func_name}({param_str})')
        self.emit_raw('{')

        # Initialize parameter registers
        for i, p in enumerate(self.parameters):
            self.set_reg(i, ('expr', p))

        # Pre-pass: removed (register updates happen in main loop for silent instructions)

        # Main decompile loop
        for inst in self.instructions:
            ip = inst['ip']
            self._current_ip = ip  # Track for emit suppression
            op = inst['op']
            arg0 = inst['arg0']
            arg1 = inst['arg1']
            arg2 = inst['arg2']
            arg3 = inst['arg3']

            # Update register state for silent instructions (no output emitted)
            # But NOT for compound chain terminators (they need decompile_inst to emit)
            if ip in self.silent_ips and ip not in self.compound_chain_terminators:
                if op == OP_MOVE:
                    self.set_reg(arg0, self.get_reg(arg1))
                elif op == OP_LOAD:
                    self.set_reg(arg0, ('const', arg1))
                elif op == OP_LOADINT:
                    self.set_reg(arg0, ('int', signed32(arg1)))
                elif op == OP_LOADBOOL:
                    self.set_reg(arg0, ('bool', 'true' if arg1 else 'false'))
                elif op == OP_LOADNULLS:
                    for i in range(arg1):
                        self.set_reg(arg0 + i, ('null', 'null'))
                elif op == OP_LOADROOT:
                    self.set_reg(arg0, ('expr', 'this'))
                elif op == OP_GET:
                    obj = self.get_reg(arg1)
                    key = self.get_reg(arg2)
                    self.set_reg(arg0, ('expr', f'{obj}[{key}]'))
                elif op == OP_GETK:
                    obj = self.get_reg(arg2)
                    key = self.literals[arg1] if arg1 < len(self.literals) else f'lit{arg1}'
                    self.set_reg(arg0, ('expr', f'{obj}.{key}'))
                elif op == OP_GETOUTER:
                    self.set_reg(arg0, self.get_reg(arg1))
                elif op in (OP_ADD, OP_SUB, OP_MUL, OP_DIV, OP_MOD):
                    ops_map = {OP_ADD: '+', OP_SUB: '-', OP_MUL: '*', OP_DIV: '/', OP_MOD: '%'}
                    left = self.get_reg(arg2)
                    right = self.get_reg(arg1)
                    self.set_reg(arg0, ('expr', f'({left} {ops_map[op]} {right})'))
                elif op in (OP_EQ, OP_NE):
                    left = self.get_reg(arg2)
                    right = self.get_reg(arg1)
                    opchar = '==' if op == OP_EQ else '!='
                    self.set_reg(arg0, ('expr', f'({left} {opchar} {right})'))
                elif op == OP_CMP:
                    left = self.get_reg(arg2)
                    right = self.get_reg(arg1)
                    cmp_ops = {CMP_G: '>', CMP_GE: '>=', CMP_L: '<', CMP_LE: '<=', CMP_3W: '<=>'}
                    opchar = cmp_ops.get(arg3, f'cmp{arg3}')
                    self.set_reg(arg0, ('expr', f'({left} {opchar} {right})'))
                elif op == OP_NOT:
                    src = self.get_reg(arg1)
                    self.set_reg(arg0, ('expr', f'(!{src})'))
                elif op == OP_NEG:
                    src = self.get_reg(arg1)
                    self.set_reg(arg0, ('expr', f'(-{src})'))
                elif op == OP_DMOVE:
                    self.set_reg(arg0, self.get_reg(arg2))
                    self.set_reg(arg0 + 1, self.get_reg(arg2 + 1))
                continue

            # Process control flow blocks at this IP
            self.process_blocks_at_ip(ip)

            # Emit label if needed (and not part of control flow or compound chain)
            if ip in self.pending_labels and ip not in self.cf_blocks and ip not in self.silent_ips and self.pending_labels[ip] in self.referenced_labels:
                self.emit_raw(f'{self.pending_labels[ip]}:')

            self.decompile_inst(ip, op, arg0, arg1, arg2, arg3)

        # Close any remaining blocks in reverse (innermost first)
        while self.block_stack:
            top = self.block_stack.pop()
            block_indent = top.get('open_indent', self.indent_level - 1)
            old_indent = self.indent_level
            self.indent_level = block_indent
            self.emit('}')
            self.indent_level = old_indent

        self.emit_raw('}')

        # Post-processing: clean up output
        result = '\n'.join(self.output_lines)
        result = self.post_process(result)
        return result

    def decompile_inst(self, ip, op, arg0, arg1, arg2, arg3):
        """Decompile a single instruction."""
        # Handle compound AND/OR chain terminators (JZ or RETURN)
        if ip in self.compound_chain_terminators:
            # Allow emit for terminator (it's in silent_ips but we want its output)
            self.silent_ips.discard(ip)
            chain_info = self.compound_chain_terminators[ip]
            # Resolve all conditions from the chain using current register state
            conditions = []
            for c in chain_info['conditions']:
                cip = c['ip']
                cinst = self.instructions[cip]
                if cinst['op'] in (OP_AND, OP_OR):
                    conditions.append(self.get_reg(cinst['arg0']))
                elif cinst['op'] == OP_JZ:
                    conditions.append(self.get_reg(cinst['arg0']))
                elif cinst['op'] == OP_RETURN and cinst['arg0'] != 0xFF:
                    conditions.append(self.get_reg(cinst['arg0']))
            sep = ' && ' if chain_info['chain_op'] == OP_AND else ' || '
            compound_cond = sep.join(conditions) if conditions else 'true'
            if op == OP_JZ:
                # Guard clause: if (a && b && c) { ... }
                self.emit(f'if (({compound_cond}))')
                self.emit('{')
                self.indent_level += 1
                exit_ip = ip + 1 + signed32(arg1)
                self.block_stack.append({
                    'entry_ip': ip,
                    'type': 'simple_if',
                    'exit_ip': exit_ip,
                    'open_indent': self.indent_level - 1,
                    'dead_code': False,
                })
                # Compound return: return (a || b || c);
                self.emit(f'return ({compound_cond});')
            return

        # Handle guard block starts (AND/OR targeting non-JZ/RETURN)
        if ip in self.guard_blocks:
            gb = self.guard_blocks[ip]
            source_ip = gb['source_ip']
            # Get condition from the source AND/OR instruction
            source_inst = self.instructions[source_ip]
            source_cond = self.get_reg(source_inst['arg0'])
            # Collect extra conditions from chain
            all_conds = [source_cond]
            for ec in gb.get('extra_conditions', []):
                ec_val = self.get_reg(ec['cond_reg'])
                all_conds.append(ec_val)
            if len(all_conds) > 1:
                compound_cond = ' && '.join(all_conds)
                self.emit(f'if ({compound_cond})')
            else:
                if gb['chain_op'] == OP_AND:
                    self.emit(f'if ({source_cond})')
                else:  # OP_OR
                    self.emit(f'if ({source_cond})')
            self.emit('{')
            self.indent_level += 1
            self.block_stack.append({
                'entry_ip': ip,
                'type': 'simple_if',
                'exit_ip': gb['end_ip'],
                'open_indent': self.indent_level - 1,
                'dead_code': False,
            })
            # Continue to process the current instruction normally

        # Skip instructions that are part of control flow blocks
        if self.is_in_cf_block(ip):
            # For JZ: convert to if block opening
            if op == OP_JZ and ip in self.cf_blocks and self.cf_blocks[ip].get('type') == 'if':
                # Check if this JZ is also a compound chain terminator with pre-resolved conditions
                cond_reg = arg0
                cond = self.get_reg(cond_reg)
                self.emit(f'if ({cond})')
                self.emit('{')
                self.indent_level += 1
                blk = {
                    'entry_ip': ip,
                    'type': 'simple_if',
                    'exit_ip': self.cf_blocks[ip]['exit_ip'],
                    'open_indent': self.indent_level - 1,
                    'dead_code': False,
                }
                if 'original_target' in self.cf_blocks[ip]:
                    blk['original_target'] = self.cf_blocks[ip]['original_target']
                self.block_stack.append(blk)
                return
            # For JCMP: convert to if block opening
            if op == OP_JCMP and ip in self.cf_blocks and self.cf_blocks[ip].get('type') == 'if':
                left = self.get_reg(arg2)
                right = self.get_reg(arg0)
                cmp_ops = {CMP_G: '>', CMP_GE: '>=', CMP_L: '<', CMP_LE: '<=', CMP_3W: '<=>'}
                opchar = cmp_ops.get(arg3, f'cmp{arg3}')
                self.emit(f'if (({left} {opchar} {right}))')
                self.emit('{')
                self.indent_level += 1
                blk = {
                    'entry_ip': ip,
                    'type': 'simple_if',
                    'exit_ip': self.cf_blocks[ip]['exit_ip'],
                    'open_indent': self.indent_level - 1,
                    'dead_code': False,
                }
                if 'original_target' in self.cf_blocks[ip]:
                    blk['original_target'] = self.cf_blocks[ip]['original_target']
                self.block_stack.append(blk)
                return
            # For FOREACH: open foreach block
            if op == OP_FOREACH and ip in self.cf_blocks and self.cf_blocks[ip].get('type') == 'foreach':
                back_ip = self.cf_blocks[ip].get('back_ip')
                container = self.get_reg(arg1) if arg1 != 0xFF else '?'
                self.emit(f'foreach (local key, value in {container})')
                self.emit('{')
                self.indent_level += 1
                self.block_stack.append({
                    'entry_ip': ip,
                    'type': 'foreach',
                    'exit_ip': back_ip,
                    'open_indent': self.indent_level - 1,
                    'dead_code': False,
                })
                return
            # For foreach_back JMP: skip (loop back-edge)
            if op == OP_JMP and ip in self.cf_blocks and self.cf_blocks[ip].get('type') == 'foreach_back':
                return
            # For JMP: skip if part of control flow
            if op == OP_JMP:
                return
            # For POSTFOREACH: handled by foreach_close block
            if op == OP_POSTFOREACH:
                return

        # Flush pending array if pattern breaks (only when register is overwritten)
        if self.pending_array_reg is not None:
            if op == OP_NEWOBJ and arg0 == self.pending_array_reg and arg3 != NOT_ARRAY:
                self.set_reg(self.pending_array_reg, ('expr', '[]'))
                self.pending_array_reg = None
                self.pending_array_items = []
        if self.pending_table_reg is not None:
            if op == OP_NEWOBJ and arg0 == self.pending_table_reg and arg3 != NOT_TABLE:
                self.set_reg(self.pending_table_reg, ('expr', '{}'))
                self.pending_table_reg = None
                self.pending_table_items = {}

        if op == OP_LINE:
            self.line_num = arg1
            return

        if op == OP_LOAD:
            # TARGET = literals[arg1]
            self.set_reg(arg0, ('str', self.get_literal(arg1)))
            return

        if op == OP_LOADINT:
            # TARGET = (SQInteger)arg1
            self.set_reg(arg0, ('int', signed32(arg1)))
            return

        if op == OP_LOADFLOAT:
            # TARGET = *(SQFloat*)&arg1
            fval = struct.unpack('f', struct.pack('I', arg1))[0]
            self.set_reg(arg0, ('float', fval))
            return

        if op == OP_DLOAD:
            # TARGET = literals[arg1]; STK(arg2) = literals[arg3]
            self.set_reg(arg0, ('str', self.get_literal(arg1)))
            self.set_reg(arg2, ('str', self.get_literal(arg3)))
            return

        if op == OP_LOADBOOL:
            # TARGET = arg1 ? true : false
            self.set_reg(arg0, ('bool', bool(arg1)))
            return

        if op == OP_LOADNULLS:
            # STK(arg0)...STK(arg0+arg1-1) = null
            for i in range(arg1):
                self.set_reg(arg0 + i, ('null', None))
            return

        if op == OP_LOADROOT:
            # TARGET = root table
            self.set_reg(arg0, ('expr', 'this'))
            return

        if op == OP_MOVE:
            # TARGET = STK(arg1)
            src = self.get_reg(arg1)
            self.reg_values[arg0] = self.reg_values.get(arg1, ('expr', f'r{arg1}'))
            return

        if op == OP_DMOVE:
            # STK(arg0) = STK(arg1); STK(arg2) = STK(arg3)
            self.reg_values[arg0] = self.reg_values.get(arg1, ('expr', f'r{arg1}'))
            self.reg_values[arg2] = self.reg_values.get(arg3, ('expr', f'r{arg3}'))
            return

        if op == OP_GETK:
            # Get(STK(arg2), literals[arg1], temp_reg); TARGET = temp_reg
            # arg0 = dest, arg1 = literal index, arg2 = source object
            obj = self.get_reg(arg2)
            prop = self.get_literal(arg1)
            self.set_reg(arg0, ('expr', self.format_property_access(obj, prop)))
            return

        if op == OP_GET:
            # Get(STK(arg1), STK(arg2), temp_reg); TARGET = temp_reg
            # arg0 = dest, arg1 = object, arg2 = key
            obj = self.get_reg(arg1)
            key = self.get_raw(arg2)
            self.set_reg(arg0, ('expr', self.format_property_access(obj, key)))
            return

        if op == OP_SET:
            # Set(STK(arg1), STK(arg2), STK(arg3), arg1)
            # arg1 = object, arg2 = key, arg3 = value
            obj = self.get_reg(arg1)
            key = self.get_raw(arg2)
            val = self.get_reg(arg3)
            # Check if assigning a pending table
            if self.pending_table_reg is not None and arg3 == self.pending_table_reg:
                entries = []
                for k, v in self.pending_table_items.items():
                    if k and k[0].isalpha() and k.replace('_', '').isalnum():
                        entries.append(f'{k} = {v}')
                    else:
                        entries.append(f'"{k}" = {v}')
                table_str = '{' + ', '.join(entries) + '}'
                self.emit(f'{self.format_property_access(obj, key)} = {table_str};')
                self.pending_table_reg = None
                self.pending_table_items = {}
            # Check if assigning a pending array
            elif self.pending_array_reg is not None and arg3 == self.pending_array_reg:
                items = ', '.join(self.pending_array_items)
                self.emit(f'{self.format_property_access(obj, key)} = [{items}];')
                self.pending_array_reg = None
                self.pending_array_items = []
            else:
                self.emit(f'{self.format_property_access(obj, key)} = {val};')
                self.pending_table_reg = None
                self.pending_table_items = {}
                self.pending_array_reg = None
                self.pending_array_items = []
            return

        if op == OP_NEWSLOT:
            # NewSlot(STK(arg1), STK(arg2), STK(arg3))
            # arg1 = table, arg2 = key, arg3 = value
            obj = self.get_reg(arg1)
            key = self.get_raw(arg2)
            val = self.get_reg(arg3)
            # Collect for table literal pattern (NEWOBJ + NEWSLOT* + APPENDARRAY/SET)
            if self.pending_table_reg is not None and arg1 == self.pending_table_reg:
                self.pending_table_items[key] = val
            else:
                if key and key[0].isalpha() and key.replace('_', '').isalnum():
                    self.emit(f'{obj}.{key} <- {val};')
                else:
                    self.emit(f'{obj}["{key}"] <- {val};')
            return

        if op == OP_NEWSLOTA:
            # Class member: same as NEWSLOT but for class attributes
            obj = self.get_reg(arg2)
            key = self.get_raw(arg3)
            val_str = self.get_reg(arg1) if arg1 < self.stacksize else str(arg1)
            self.emit(f'{obj}.{key} <- {val_str};')
            return

        if op == OP_DELETE:
            # DeleteSlot(STK(arg1), STK(arg2), TARGET)
            obj = self.get_reg(arg1)
            key = self.get_raw(arg2)
            self.emit(f'delete {self.format_property_access(obj, key)};')
            return

        if op == OP_EQ:
            # TARGET = (STK(arg2) == COND_LITERAL)
            # COND_LITERAL = arg3!=0 ? literals[arg1] : STK(arg1)
            left = self.get_reg(arg2)
            if arg3 != 0:
                right = self.lit_str(arg1)
            else:
                right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} == {right})'))
            return

        if op == OP_NE:
            left = self.get_reg(arg2)
            if arg3 != 0:
                right = self.lit_str(arg1)
            else:
                right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} != {right})'))
            return

        if op == OP_ADD:
            # TARGET = STK(arg2) + STK(arg1)
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} + {right})'))
            return

        if op == OP_SUB:
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} - {right})'))
            return

        if op == OP_MUL:
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} * {right})'))
            return

        if op == OP_DIV:
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} / {right})'))
            return

        if op == OP_MOD:
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'({left} % {right})'))
            return

        if op == OP_BITW:
            # BW_OP(arg3, TARGET, STK(arg2), STK(arg1))
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            bw_ops = {BW_AND: '&', BW_OR: '|', BW_XOR: '^',
                      BW_SHIFTL: '<<', BW_SHIFTR: '>>', BW_USHIFTR: '>>>'}
            opchar = bw_ops.get(arg3, f'bitw{arg3}')
            self.set_reg(arg0, ('expr', f'({left} {opchar} {right})'))
            return

        if op == OP_CMP:
            # CMP_OP(arg3, STK(arg2), STK(arg1), TARGET)
            # CMP_OP(cmp_type, left, right, dest) -> dest = left CMP right
            left = self.get_reg(arg2)
            right = self.get_reg(arg1)
            cmp_ops = {CMP_G: '>', CMP_GE: '>=', CMP_L: '<', CMP_LE: '<=', CMP_3W: '<=>'}
            opchar = cmp_ops.get(arg3, f'cmp{arg3}')
            self.set_reg(arg0, ('expr', f'({left} {opchar} {right})'))
            return

        if op == OP_NEG:
            # TARGET = -STK(arg2)
            src = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'(-{src})'))
            return

        if op == OP_NOT:
            # TARGET = !STK(arg1)
            src = self.get_reg(arg1)
            self.set_reg(arg0, ('expr', f'(!{src})'))
            return

        if op == OP_BWNOT:
            # TARGET = ~STK(arg2)
            src = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'(~{src})'))
            return

        if op == OP_INC:
            # TARGET = STK(arg0) + arg1
            src = self.get_reg(arg0)
            inc = signed32(arg1)
            if inc == 1:
                self.set_reg(arg0, ('expr', f'({src} + 1)'))
            elif inc == -1:
                self.set_reg(arg0, ('expr', f'({src} - 1)'))
            else:
                self.set_reg(arg0, ('expr', f'({src} + {inc})'))
            return

        if op == OP_INCL:
            src = self.get_reg(arg0)
            inc = signed32(arg1)
            if inc == 1:
                self.set_reg(arg0, ('expr', f'({src} + 1)'))
            elif inc == -1:
                self.set_reg(arg0, ('expr', f'({src} - 1)'))
            else:
                self.set_reg(arg0, ('expr', f'({src} + {inc})'))
            return

        if op == OP_PINC:
            src = self.get_reg(arg0)
            inc = signed32(arg1)
            if inc == 1:
                self.set_reg(arg0, ('expr', f'{src}++'))
            elif inc == -1:
                self.set_reg(arg0, ('expr', f'{src}--'))
            else:
                self.set_reg(arg0, ('expr', f'({src} + {inc})'))
            return

        if op == OP_PINCL:
            src = self.get_reg(arg0)
            inc = signed32(arg1)
            if inc == 1:
                self.set_reg(arg0, ('expr', f'{src}++'))
            elif inc == -1:
                self.set_reg(arg0, ('expr', f'{src}--'))
            else:
                self.set_reg(arg0, ('expr', f'({src} + {inc})'))
            return

        if op == OP_COMPARITH:
            # Compound arith: arg1 = (src<<16)|val, arg2 = key, arg3 = op char
            # For OBJECT: result = src[key] OP val
            # Decode: src = arg1 >> 16, val = arg1 & 0xFFFF
            src_reg = (arg1 >> 16) & 0xFF
            val_reg = arg1 & 0xFF
            obj = self.get_reg(src_reg)
            key = self.get_raw(arg2)
            val = self.get_reg(val_reg)
            ops = {0: '+', 1: '-', 2: '*', 3: '/', 4: '%'}
            opchar = ops.get(arg3, f'op{arg3}')
            target = self.format_property_access(obj, key)
            self.emit(f'{target} = {target} {opchar} {val};')
            return

        if op == OP_EXISTS:
            # TARGET = (literal[arg1] in STK(arg2))
            key = self.lit_str(arg1)
            obj = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'({key} in {obj})'))
            return

        if op == OP_INSTANCEOF:
            # TARGET = STK(arg0) instanceof STK(arg2)
            # Wait: actually from compiler, BIN_EXP puts op1=right into arg1
            # INSTANCEOF uses: IsInstanceOf(TARGET, STK(arg2), STK(arg1))
            left = self.get_reg(arg0)
            right = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'({left} instanceof {right})'))
            return

        if op == OP_AND:
            # if(IsFalse(TARGET)) ip += arg1
            offset = signed32(arg1)
            label = f'__label_{ip + 1 + offset}'
            cond = self.get_reg(arg0)
            self.referenced_labels.add(label)
            self.emit(f'if (!({cond})) goto {label};')
            return

        if op == OP_OR:
            # if(IsTrue(TARGET)) ip += arg1
            offset = signed32(arg1)
            label = f'__label_{ip + 1 + offset}'
            cond = self.get_reg(arg0)
            self.referenced_labels.add(label)
            self.emit(f'if ({cond}) goto {label};')
            return

        if op == OP_JMP:
            # ci->_ip += sarg1
            # Skip if this JMP was handled by control flow analysis
            if ip in self.cf_instructions and ip in self.cf_blocks:
                return  # Already handled by control flow
            offset = signed32(arg1)
            label = f'__label_{ip + 1 + offset}'
            self.referenced_labels.add(label)
            self.emit(f'goto {label};')
            return

        if op == OP_JCMP:
            # CMP_OP(cmp_type, STK(arg2), STK(arg0)); if false, ip += sarg1
            # Skip if this JCMP was handled by control flow analysis
            if ip in self.cf_instructions and ip in self.cf_blocks:
                return  # Already handled by control flow
            left = self.get_reg(arg2)
            right = self.get_reg(arg0)
            cmp_ops = {CMP_G: '>', CMP_GE: '>=', CMP_L: '<', CMP_LE: '<=', CMP_3W: '<=>'}
            opchar = cmp_ops.get(arg3, f'cmp{arg3}')
            offset = signed32(arg1)
            label = f'__label_{ip + 1 + offset}'
            self.referenced_labels.add(label)
            self.emit(f'if (!({left} {opchar} {right})) goto {label};')
            return

        if op == OP_JZ:
            # if(IsFalse(STK(arg0))) ip += sarg1
            # Skip if this JZ was handled by control flow analysis
            if ip in self.cf_instructions and ip in self.cf_blocks:
                return  # Already handled by control flow
            cond = self.get_reg(arg0)
            offset = signed32(arg1)
            label = f'__label_{ip + 1 + offset}'
            self.referenced_labels.add(label)
            self.emit(f'if (!({cond})) goto {label};')
            return

        if op == OP_CALL:
            # TARGET = CallClosure(STK(arg1), arg3, STK(arg2))
            # arg0 = dest (0xFF = void), arg1 = func, arg2 = args_start, arg3 = nargs
            func = self.get_reg(arg1)
            args = []
            start = arg2
            count = arg3
            # Skip first arg if it's the prepared object for this function (implicit 'this')
            obj_reg = self.prepcall_obj_map.get(arg1)
            if obj_reg is not None and count > 0 and arg2 == obj_reg:
                start = arg2 + 1
                count = arg3 - 1
            for i in range(count):
                args.append(self.get_reg(start + i))
            call_expr = f'{func}({", ".join(args)})'
            self.prepared_obj_reg = None
            if arg0 == 0xFF:
                self.emit(f'{call_expr};')
            else:
                self.set_reg(arg0, ('expr', call_expr))
            return

        if op == OP_TAILCALL:
            func = self.get_reg(arg1)
            args = []
            start = arg2
            count = arg3
            obj_reg = self.prepcall_obj_map.get(arg1)
            if obj_reg is not None and count > 0 and arg2 == obj_reg:
                start = arg2 + 1
                count = arg3 - 1
            for i in range(count):
                args.append(self.get_reg(start + i))
            self.prepared_obj_reg = None
            self.emit(f'return {func}({", ".join(args)});')
            return

        if op == OP_RETURN:
            # Flush any pending table/array
            if self.pending_table_reg is not None and arg0 == self.pending_table_reg:
                entries = []
                for k, v in self.pending_table_items.items():
                    if k and k[0].isalpha() and k.replace('_', '').isalnum():
                        entries.append(f'{k} = {v}')
                    else:
                        entries.append(f'"{k}" = {v}')
                table_str = '{' + ', '.join(entries) + '}'
                self.pending_table_reg = None
                self.pending_table_items = {}
                self.emit(f'return {table_str};')
            elif self.pending_array_reg is not None and arg0 == self.pending_array_reg:
                items = ', '.join(self.pending_array_items)
                self.pending_array_reg = None
                self.pending_array_items = []
                self.emit(f'return [{items}];')
            elif arg0 == 0xFF:
                self.emit('return;')
            else:
                self.emit(f'return {self.get_reg(arg0)};')
            return

        if op == OP_PREPCALLK:
            # Get(STK(arg2), literals[arg1], temp_reg); STK(arg3) = STK(arg2)
            obj = self.get_reg(arg2)
            prop = self.get_literal(arg1)
            self.set_reg(arg0, ('expr', self.format_property_access(obj, prop)))
            self.reg_values[arg3] = self.reg_values.get(arg2, ('expr', f'r{arg2}'))
            self.prepared_obj_reg = arg3
            self.prepcall_obj_map[arg0] = arg3  # func_reg -> obj_reg
            return

        if op == OP_PREPCALL:
            obj = self.get_reg(arg2)
            key = self.get_raw(arg1)
            self.set_reg(arg0, ('expr', self.format_property_access(obj, key)))
            self.reg_values[arg3] = self.reg_values.get(arg2, ('expr', f'r{arg2}'))
            self.prepared_obj_reg = arg3
            self.prepcall_obj_map[arg0] = arg3
            return

        if op == OP_NEWOBJ:
            if arg3 == NOT_TABLE:
                self.set_reg(arg0, ('expr', '{}'))
                self.pending_table_reg = arg0
                self.pending_table_items = {}
            elif arg3 == NOT_ARRAY:
                self.set_reg(arg0, ('expr', '[]'))
                self.pending_array_reg = arg0
                self.pending_array_items = []
            elif arg3 == NOT_CLASS:
                self.set_reg(arg0, ('expr', 'class {}'))
            return

        if op == OP_APPENDARRAY:
            if arg2 == AAT_STACK:
                val = self.get_reg(arg1)
            elif arg2 == AAT_LITERAL:
                val = self.lit_str(arg1)
            elif arg2 == AAT_INT:
                val = str(arg1)
            elif arg2 == AAT_FLOAT:
                fval = struct.unpack('f', struct.pack('I', arg1))[0]
                val = str(fval)
            elif arg2 == AAT_BOOL:
                val = 'true' if arg1 else 'false'
            else:
                val = f'appendarray_type{arg2}({arg1})'
            # Check if this appends a pending table
            if self.pending_table_reg is not None and arg1 == self.pending_table_reg and arg2 == AAT_STACK:
                # Convert pending table to literal and add to array items
                entries = []
                for k, v in self.pending_table_items.items():
                    if k and k[0].isalpha() and k.replace('_', '').isalnum():
                        entries.append(f'{k} = {v}')
                    else:
                        entries.append(f'"{k}" = {v}')
                table_str = '{' + ', '.join(entries) + '}'
                self.pending_table_reg = None
                self.pending_table_items = {}
                if self.pending_array_reg is not None and arg0 == self.pending_array_reg:
                    self.pending_array_items.append(table_str)
                else:
                    self.emit(f'{self.get_reg(arg0)}.push({table_str});')
            elif self.pending_array_reg is not None and arg0 == self.pending_array_reg:
                self.pending_array_items.append(val)
            else:
                self.emit(f'{self.get_reg(arg0)}.push({val});')
            return

        if op == OP_TYPEOF:
            # TARGET = typeof(STK(arg2))
            src = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'typeof({src})'))
            return

        if op == OP_CLONE:
            # TARGET = clone STK(arg2)
            src = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'clone {src}'))
            return

        if op == OP_CLOSURE:
            # TARGET = closure(arg1)
            self.set_reg(arg0, ('expr', f'function() /* closure #{arg1} */'))
            return

        if op == OP_FOREACH:
            # foreach(container=STK(arg2), key=STK(arg1+1), val=STK(arg1), iterator)
            # arg0 = iterator, arg1 = key/val base, arg2 = container
            container = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'foreach({container})'))
            return

        if op == OP_POSTFOREACH:
            return  # End of foreach body marker

        if op == OP_PUSHTRAP:
            # try { ... trap at ip + 1 + arg1
            self.emit('try {')
            self.indent_level += 1
            return

        if op == OP_POPTRAP:
            self.indent_level = max(1, self.indent_level - 1)
            self.emit('}')
            return

        if op == OP_THROW:
            self.emit(f'throw {self.get_reg(arg0)};')
            return

        if op == OP_GETOUTER:
            # TARGET = outer[arg1]
            self.set_reg(arg0, ('expr', f'outer[{arg1}]'))
            return

        if op == OP_SETOUTER:
            # outer[arg1] = STK(arg0)
            self.emit(f'outer[{arg1}] = {self.get_reg(arg0)};')
            return

        if op == OP_GETBASE:
            # TARGET = base (superclass)
            self.set_reg(arg0, ('expr', 'base'))
            return

        if op == OP_DELEGATE:
            # Delegation
            src = self.get_reg(arg2)
            self.set_reg(arg0, ('expr', f'delegate({src})'))
            return

        if op == OP_YIELD:
            self.emit(f'yield {self.get_reg(arg2)};')
            return

        if op == OP_RESUME:
            self.set_reg(arg0, ('expr', f'resume {self.get_reg(arg2)}'))
            return

        if op == OP_CLOSE:
            return  # Close captured variables

        # Unknown opcode
        self.emit(f'/* unknown op 0x{op:02X}: arg0={arg0} arg1={arg1} arg2={arg2} arg3={arg3} */')


def decompile_function(func_info):
    """Decompile a single function to source code."""
    try:
        d = Decompiler(func_info)
        return d.decompile()
    except Exception as e:
        return f'// Error decompiling: {e}'


def main():
    dump_file = 'C:/Users/Administrator/Documents/Battle Brothers/savegames/final_dump/all_funcprotos_v2.json'

    print("Loading function data...")
    with open(dump_file, 'r', encoding='utf-8') as f:
        all_funcs = json.load(f)

    print(f"Loaded {len(all_funcs)} functions")

    by_source = defaultdict(list)
    for func in all_funcs:
        src = func.get('source', '<unknown>')
        by_source[src].append(func)

    print(f"Unique source files: {len(by_source)}")

    # Load Chinese mod file list
    import zipfile
    cn_nut = set()
    try:
        z = zipfile.ZipFile('C:/SteamLibrary/steamapps/common/Battle Brothers/data/data_cn_s_20240303.zip')
        for name in z.namelist():
            if name.endswith('.nut'):
                cn_nut.add(name)
    except:
        pass

    out_dir = 'C:/Users/Administrator/Documents/Battle Brothers/savegames/decompiled_v3'
    os.makedirs(out_dir, exist_ok=True)

    decompiled_count = 0
    skipped_count = 0
    error_count = 0
    total_files = 0

    for source_path in sorted(by_source.keys()):
        funcs = by_source[source_path]

        if source_path in cn_nut:
            skipped_count += 1
            continue

        total_files += 1
        clean_path = source_path
        if clean_path.startswith('data\\') or clean_path.startswith('data/'):
            clean_path = clean_path[5:]
        out_path = os.path.join(out_dir, clean_path.replace('/', os.sep))
        os.makedirs(os.path.dirname(out_path), exist_ok=True)

        output_lines = []
        output_lines.append(f'// Decompiled from Battle Brothers memory (v3 - correct opcodes)')
        output_lines.append(f'// Source: {source_path}')
        output_lines.append(f'// Functions: {len(funcs)}')
        output_lines.append('')

        for func in sorted(funcs, key=lambda f: f.get('name') or ''):
            name = func.get('name', '<anonymous>')
            try:
                result = decompile_function(func)
                output_lines.append(result)
            except Exception as e:
                output_lines.append(f'// Error in {name}: {e}')
                error_count += 1
            output_lines.append('')

        with open(out_path, 'w', encoding='utf-8') as f:
            f.write('\n'.join(output_lines))

        decompiled_count += 1
        if decompiled_count % 50 == 0:
            print(f"  Decompiled {decompiled_count} files...")

    print(f"\nResults:")
    print(f"  Total source files: {len(by_source)}")
    print(f"  Skipped (in Chinese mod): {skipped_count}")
    print(f"  Decompiled: {decompiled_count}")
    print(f"  Errors: {error_count}")
    print(f"  Output: {out_dir}")


if __name__ == '__main__':
    main()
