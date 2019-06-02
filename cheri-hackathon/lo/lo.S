# Copyright 2019 The Project Oak participants
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.set MIPS_SZCAP, _MIPS_SZCAP
    .text
    .global __start
    .ent __start

.equ GP_BASE, 0xffffffff80707ff0
.equ MALTA_UART_BASE, 0x180003f8
.equ MALTA_UART_SIZE, 0x40
.equ MALTA_UART_RXTX_OFFSET, 0x00
.equ MIPS_SR_COP_2_BIT, 0x40000000

__start:
    # Enabling CHERI coprocessor
    li	       $t0,1
    move       $t0, $t9

    li         $t1, MIPS_SR_COP_2_BIT
    mfc0       $t0, $12 // COP0 status register
    or         $t0, $t1
    mtc0       $t0, $12
 
    # C1 <- KCC (capability with maximum permissions and all memory range)
    cgetkcc	$c1

    # Restricting C1 to memory-mapped I/O range for UART
    li          $t1, MALTA_UART_BASE
    lui         $t2, 0xa000 # To get correct address in physical memory
    or          $t1, $t1, $t2
    csetoffset  $c1, $c1, $t1
    li		$t2, MALTA_UART_SIZE
    csetbounds  $c1, $c1, $t2

    li		$t2, MALTA_UART_RXTX_OFFSET

    # Initializing gp, so we can call external symbols
    li          $gp, GP_BASE

    # Writing 'l':
    li          $t1, 'l'
    csb         $t1, $t2, 0($c1)

    # Calling C
    jal         foo
 
    # Writing 'o':
    li          $t1, 'o'
    csb         $t1, $t2, 0($c1)

    # Accessing capability in a wrong way (violating range)
    li	$t2, 0x80
    csb       $t1, $t2, 0($c1)
loop:
    j   	loop

