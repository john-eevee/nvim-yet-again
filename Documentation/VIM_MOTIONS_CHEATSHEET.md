# Vim Motions Cheatsheet
## "I Want To..." Style Guide

A practical guide to Vim motions organized by editing tasks, from common to clever.

---

## Table of Contents
1. [Basic Navigation](#basic-navigation)
2. [Character Level Editing](#character-level-editing)
3. [Word Level Editing](#word-level-editing)
4. [Line Level Editing](#line-level-editing)
5. [Paragraph & Block Editing](#paragraph--block-editing)
6. [Search & Replace](#search--replace)
7. [Selection & Deletion](#selection--deletion)
8. [Copy & Paste Tricks](#copy--paste-tricks)
9. [Indentation & Formatting](#indentation--formatting)
10. [Advanced & Clever Tricks](#advanced--clever-tricks)

---

# BASIC NAVIGATION

## I want to...

### ...move to the beginning of the line
```
0  or  Home
```
Move to the first character (ignoring indentation)
```
^  or  _
```

### ...move to the end of the line
```
$  or  End
```

### ...move to a specific character on this line
```
f{char}   Forward to character
t{char}   Forward to before character
F{char}   Backward to character
T{char}   Backward to before character
```
**Example**: `f)` jumps to the next `)` on the line

### ...move to the next word
```
w   Start of next word (including punctuation)
W   Start of next word (ignoring punctuation)
```

### ...move to the end of current word
```
e   End of current word (including punctuation)
E   End of current word (ignoring punctuation)
```

### ...move to the previous word
```
b   Start of previous word (including punctuation)
B   Start of previous word (ignoring punctuation)
```

### ...jump to a specific line number
```
:123        Go to line 123
123G        Go to line 123
gg          Go to first line
G           Go to last line
Ctrl+g      Show current line number
```

### ...jump to the matching bracket/paren
```
%
```
Works with: `()`, `[]`, `{}`

### ...move to a specific column
```
|           Go to column 1
5|          Go to column 5
```

### ...page down/up
```
Ctrl+f      Forward full page
Ctrl+b      Backward full page
Ctrl+d      Down half page
Ctrl+u      Up half page
```

### ...keep position but scroll the window
```
zt          Current line to top
zz          Current line to middle
zb          Current line to bottom
```

---

# CHARACTER LEVEL EDITING

## I want to...

### ...change one character
```
r{char}
```
**Example**: `rx` replaces character under cursor with x

### ...change one character and enter insert mode
```
s
```
Equivalent to `xi` (delete and insert)

### ...delete one character forward/backward
```
x           Delete forward (under cursor)
X           Delete backward (before cursor)
```

### ...delete and enter insert mode (change)
```
c           Followed by motion
```
**Examples**:
- `cw` - change word
- `c$` - change to end of line
- `ct,` - change until comma

### ...swap two characters
```
xp
```
Delete character and paste after (swaps adjacent chars)

### ...capitalize a character
```
~
```
Toggle case of character under cursor

### ...repeat last change
```
.
```

### ...undo/redo
```
u           Undo last change
Ctrl+r      Redo
```

---

# WORD LEVEL EDITING

## I want to...

### ...select a word and change it
```
cw          Change from cursor to end of word
ciw         Change entire word (even if mid-word)
caw         Change word + space after
```

### ...delete a word
```
dw          Delete word forward
db          Delete word backward
diw         Delete entire word
daw         Delete word + space
```

### ...copy a word
```
yw          Copy word forward
yiw         Copy entire word
yaw         Copy word + space
```

### ...add a character to every word on a line
```
:%s/\(.*\)/\1x/
```
Or use visual selection + macro (see Advanced)

### ...delete every other word
```
:g/word/d
```

### ...swap two words
```
viwd"dviWP
```
Select word, delete, select next word, paste

### ...put spaces around a word
```
ciw {word}
```

### ...join this word with the next word (no space)
```
J           Join lines
```

---

# LINE LEVEL EDITING

## I want to...

### ...delete the entire line
```
dd
```

### ...delete multiple lines
```
3dd         Delete 3 lines (current + 2 below)
d10j        Delete current + 10 lines down
```

### ...change entire line
```
cc          Change entire line (keeps indentation)
C           Change to end of line
0cG         Change to end of file
```

### ...copy entire line
```
yy          Copy current line
5yy         Copy 5 lines
```

### ...duplicate a line
```
yyp
```
Copy line and paste below

### ...duplicate and comment a line
```
yyp{select}gc{comment_toggle}
```
(Requires comment plugin)

### ...move the line down/up
```
:m +1       Move line down
:m -2       Move line up
```
Or use plugins like `vim-move`

### ...insert a new line below
```
o           Insert line below and enter insert mode
O           Insert line above and enter insert mode
```

### ...add content to the beginning of multiple lines
```
^i{text}Esc
```
In visual line mode, then `I` for each line

### ...add content to the end of multiple lines
```
A{text}Esc
```
In visual line mode, then `A` for each line

### ...delete from cursor to end of line
```
D
```

### ...join line with next line
```
J
```

---

# PARAGRAPH & BLOCK EDITING

## I want to...

### ...select entire paragraph
```
vip         Visual select inner paragraph
vap         Visual select paragraph + blank lines
yap         Copy paragraph
dap         Delete paragraph
cap         Change paragraph
```

### ...delete multiple paragraphs
```
2dap
```

### ...select code block / function
```
vif         Select inner function (requires plugin)
vaf         Select function + brackets
viB         Select inner block
vaB         Select block + braces
```

### ...delete everything in curly braces
```
di{
```
Or: `di}`, `di)`, `di]`, `di"`

### ...change content in parentheses
```
ci(
```
Or: `ci)`, `ci[`, `ci]`, `ci{`, `ci}`

### ...select around braces (including braces)
```
va{         Select around curly braces
da{         Delete around curly braces
ca{         Change around curly braces
```

### ...select nested structures
```
vii         Select inner inner block
```
Keep nesting deeper with more `i`s

### ...indent a block
```
>ib         Indent inner block
<ap         Outdent paragraph
```

---

# SEARCH & REPLACE

## I want to...

### ...find next occurrence
```
/pattern    Search forward
n           Next match
N           Previous match
```

### ...find previous occurrence
```
?pattern    Search backward
```

### ...find word under cursor
```
*           Find next occurrence
#           Find previous occurrence
g*          Find as substring
```

### ...find and replace on current line
```
:s/old/new/
```

### ...find and replace all occurrences in file
```
:%s/old/new/g
```

### ...find and replace with confirmation
```
:%s/old/new/gc
```
`y` to replace, `n` to skip, `a` to replace all

### ...find and replace in selected lines
```
:s/old/new/g     (In visual selection)
```

### ...find and replace with case sensitivity
```
:%s/old/new/g    Matches case
:%s/old/new/gi   Case insensitive
```

### ...find and replace word boundaries
```
:%s/\<old\>/new/g
```
`\<` and `\>` match word boundaries

### ...search and replace with regex groups
```
:%s/\(.*\) \(.*\)/\2 \1/
```
Swap two words separated by space

### ...find all occurrences of word
```
:[range]g/pattern/
```

### ...delete all lines containing pattern
```
:g/pattern/d
```

### ...copy all lines containing pattern
```
:g/pattern/y A
```

---

# SELECTION & DELETION

## I want to...

### ...select from cursor to end of word
```
vw
```

### ...select entire word
```
viw         Select inner word
vaw         Select word + space
```

### ...select to end of line
```
v$
```

### ...select from beginning to cursor on line
```
v0
```

### ...select to next line
```
vj          Extend selection down
v5j         Select 5 lines down
```

### ...select in visual block mode
```
Ctrl+v      Enter visual block mode
```

### ...select columns 5-20 on multiple lines
```
Ctrl+v      Enter block mode
5l          Move right 5 columns
3j          Move down 3 lines
I{text}Esc  Insert at all selections
```

### ...select and delete (and keep position)
```
d
```

### ...select and delete with paste
```
d           Then yank something and p to paste
```

### ...delete everything except selection
```
!          (In select mode - keep and delete around)
```

### ...delete matching pairs quickly
```
di"         Delete everything in quotes
da"         Delete quotes and content
```

### ...delete until pattern
```
d/pattern/
```

---

# COPY & PASTE TRICKS

## I want to...

### ...copy current line
```
yy
```

### ...copy to end of line
```
y$
```

### ...copy from position to end of word
```
ye
```

### ...copy paragraph
```
yap
```

### ...paste after cursor
```
p
```

### ...paste before cursor
```
P
```

### ...paste and keep original
```
yy
p           Paste (original still in buffer)
```

### ...copy to a named register
```
"ayaw       Copy word to register 'a'
"by$        Copy to end of line to register 'b'
```

### ...paste from named register
```
"ap         Paste from register 'a'
```

### ...view all registers
```
:reg
```

### ...copy multiple things and paste
```
"a{select}y
"b{select}y
"ap         Paste first
"bp         Paste second
```

### ...copy without the newline
```
0y$         Copy line without newline
```

### ...duplicate a word
```
yiw
p           Paste after
```

### ...copy and increment
```
yy
Ctrl+a      (With appropriate plugin)
```

### ...copy last search pattern
```
"/p         Paste last search
```

### ...paste from system clipboard
```
"+p         Paste from system clipboard
"*p         Paste from selection (X11)
```

### ...copy to system clipboard
```
"+yaw       Copy word to system clipboard
"+yy        Copy line to system clipboard
```

---

# INDENTATION & FORMATTING

## I want to...

### ...indent current line
```
>>
```

### ...unindent current line
```
<<
```

### ...indent 5 lines
```
5>>
```

### ...indent entire paragraph
```
>ap
```

### ...unindent to column 0
```
0<
```

### ...indent all lines in a block
```
>i{         Indent inner braces
```

### ...indent selected lines
```
> (Visual selection)
```

### ...auto-indent to match surrounding
```
==
```

### ...auto-indent entire file
```
gg=G
```

### ...auto-indent a function
```
=af         Auto-indent function
```

### ...fix indentation of copied code
```
p=`]        Paste and auto-indent
```

### ...add spaces before character
```
i{space}{space}Esc
```

---

# ADVANCED & CLEVER TRICKS

## I want to...

### ...change everything inside quotes
```
ci"         Inside double quotes
ci'         Inside single quotes
ci`         Inside backticks
```

### ...delete to next occurrence of character
```
d/x/        Delete until 'x'
```

### ...replace all instances of word in line
```
ciw{new}Esc
n.          Find next, repeat replacement
```

### ...swap line with above
```
ddkP        Delete, go up, paste
```

### ...move line to end of file
```
dd
G
p
```

### ...duplicate everything to end of file
```
gg
yG
G
p
```

### ...surround word with brackets (needs plugin)
```
ysiw)       Surround word with parens
ysiw}       Surround word with braces
```

### ...change surrounding quotes
```
cs"'        Change double quotes to single
```

### ...delete surrounding brackets
```
ds)
```

### ...select between quotes even with nesting
```
v
t"          Select to quote
```

### ...change everything between tags
```
cit         Change inner tag
```

### ...select from cursor to exact position
```
/pattern
v           Start selection
?pattern
           Go to pattern (selection extended)
```

### ...record and play back edits
```
qa          Start recording to register 'a'
{edits}
q           Stop recording
@a          Play back register 'a'
@@          Play back last macro
3@a         Play back macro 'a' 3 times
```

### ...apply macro to every line in selection
```
:'<,'>normal @a
```

### ...find and delete lines matching pattern
```
:g/pattern/d
```

### ...find and move lines matching pattern
```
:g/pattern/m $
```

### ...join lines intelligently
```
J           Join with space
gJ          Join without space
```

### ...join and reformat paragraph
```
gq)         Reformat paragraph
```

### ...convert to uppercase
```
gU          Followed by motion
guaw        Make word lowercase
gUaw        Make word uppercase
```

### ...sort selected lines
```
:sort       (In visual selection)
:sort!      Reverse sort
:sort /\d   Sort by numbers
```

### ...remove all blank lines
```
:g/^$/d
```

### ...add numbers to start of line
```
:%s/^/\=line('.')-1 . '. '/
```

### ...align equals signs
```
:Tabularize /=
```
(Requires vim-tabularize plugin)

### ...reformat code section
```
=i{         Auto indent inside braces
=a)         Auto indent around parens
```

### ...toggle between single/double quotes
```
cs'"
```

### ...change word across multiple lines
```
c/word/     Change until next 'word'
```

### ...delete word and stay in position
```
bde         Delete word before
daw         Delete word at cursor
```

### ...paste at all occurrences
```
:g/pattern/s//replace/
```

### ...increment/decrement number
```
Ctrl+a      Increment number at cursor
Ctrl+x      Decrement number at cursor
5Ctrl+a     Increment by 5
```

### ...create a count prefix for repeating
```
10.         Repeat last command 10 times
5dd         Delete 5 lines
3yy         Copy 3 lines
```

### ...apply change to similar words
```
*           Find word
cgn{new}Esc
.           Repeat on next occurrence
```

### ...select all occurrences of word
```
gn          Select next match (after search)
```

### ...reverse lines
```
:g/^/m 0
```

### ...extract matches to new file
```
:g/pattern/t $
```
Copy all matches to end of file

### ...show all matches in a buffer
```
:vimgrep /pattern/g %
:copen
```

### ...navigate between matches
```
:cn         Next match in quicklist
:cp         Previous match
:cfirst     First match
:clast      Last match
```

### ...delete duplicate lines
```
:sort u
```

### ...find difference between two selections
```
v{select}
:DiffOrig
```

---

## MOTION MODIFIERS (use with any motion)

### Delete
```
d{motion}   Delete motion
3dw         Delete 3 words
d$          Delete to end of line
```

### Change (delete and insert)
```
c{motion}   Change motion
caw         Change word
c/x/        Change until 'x'
```

### Copy (yank)
```
y{motion}   Copy motion
y5j         Copy 5 lines down
yb          Copy to word start
```

### Indent
```
>{motion}   Indent motion
<{motion}   Unindent motion
```

### Autoformat
```
={motion}   Auto format motion
=i}         Format inner braces
```

### Uppercase/Lowercase
```
gu{motion}  Make lowercase
gU{motion}  Make uppercase
~{motion}   Toggle case
```

---

## QUICK REFERENCE TABLE

| Goal | Motion |
|------|--------|
| Delete line | `dd` |
| Change word | `cw` or `ciw` |
| Copy paragraph | `yap` |
| Select to end | `v$` |
| Find and replace | `:%s/old/new/g` |
| Move line down | `:m +1` |
| Indent block | `>i{` |
| Delete to pattern | `d/pattern/` |
| Swap words | `diwd"dviWP` |
| Format paragraph | `gq)` |
| Select inner quotes | `vi"` |
| Record macro | `qa...q` |
| Repeat last edit | `.` |
| Go to line 42 | `42G` |
| Jump to bracket match | `%` |
| Undo last change | `u` |
| Increment number | `Ctrl+a` |
| Sort lines | `:sort` |
| Delete blanks | `:g/^$/d` |
| Change case | `gU` or `gu` |

---

## HELPFUL COMBINATIONS

### Triple-click in VSCode/system = Vim equivalent
```
V           Select entire line
Shift+End   Select to end (in normal mode: v$)
```

### Common workflows

**Rename variable everywhere**:
```
*           Find variable
cgn{new}Esc
.           Repeat
```

**Change function name**:
```
/function_name
cgn{new}Esc
.
.
```

**Add prefix to multiple lines**:
```
Select lines: V3j
I{prefix}Esc
```

**Add suffix to multiple lines**:
```
Select lines: V3j
A{suffix}Esc
```

**Comment/uncomment lines** (needs plugin):
```
gc          Comment/uncomment
gcc         Comment current line
gc{motion}  Comment selection
```

**Format code**:
```
gg=G        Auto-format entire file
```

**Sort imports**:
```
:sort       On selected lines
```

---

## TIPS & TRICKS

1. **Text objects are your friend**: `iw`, `aw`, `i"`, `a"`, `i{`, `a{`, etc.
2. **Use motions with operators**: `d`, `c`, `y`, `>`, `<`, `=`, `g~`
3. **Repeat with `.`**: Perfect for making similar changes
4. **Named registers**: `"a` through `"z` for organizing copies
5. **Macros**: Record complex changes with `qa...q` and replay with `@a`
6. **Search substitution**: Build complex find-replace with regex
7. **Visual modes**: `v`, `V`, `Ctrl+v` each have their use case
8. **Count prefix**: Any motion can take a count: `5w`, `3dd`, `2gq`
9. **Combining motions**: `c$`, `d}`, `y%` all work perfectly
10. **Learn incrementally**: Start with basics, add complex motions as needed

---

**Last Updated**: February 1, 2025  
**Format**: I Want To... Cheatsheet  
**For**: Vim/Neovim Users  
**Status**: Comprehensive & Practical ✅
