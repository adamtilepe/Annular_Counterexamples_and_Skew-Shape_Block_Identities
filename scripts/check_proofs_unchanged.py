#!/usr/bin/env python3
"""Check that two Lean files have identical source outside of Lean comments.

Supports nested `/- ... -/`, `--` line comments, quoted strings and escape
sequences. Only *documentation* may change in this migration.
"""
from pathlib import Path
import hashlib
import sys

def strip_comments(s: str) -> str:
    out=[]; i=0; n=len(s); depth=0; string=False
    while i<n:
        c=s[i]; nxt=s[i+1] if i+1<n else ''
        if depth:
            if c=='/' and nxt=='-': depth+=1; i+=2; continue
            if c=='-' and nxt=='/': depth-=1; i+=2; continue
            i+=1; continue
        if string:
            out.append(c)
            if c=='\\' and i+1<n:
                i+=1;out.append(s[i]);i+=1;continue
            if c=='"':string=False
            i+=1;continue
        if c=='"':string=True;out.append(c);i+=1;continue
        if c=='/' and nxt=='-':depth=1;i+=2;continue
        if c=='-' and nxt=='-':
            while i<n and s[i]!='\n':i+=1
            continue
        if not c.isspace():out.append(c)
        i+=1
    if depth:raise ValueError('Unclosed Lean block comment')
    return ''.join(out)

def main():
    if len(sys.argv)!=3:raise SystemExit('usage: check_proofs_unchanged.py OLD.lean NEW.lean')
    a=strip_comments(Path(sys.argv[1]).read_text(encoding='utf-8'))
    b=strip_comments(Path(sys.argv[2]).read_text(encoding='utf-8'))
    for label,src in [('Old',a),('New',b)]:
        print(f'{label}: {len(src)} non-comment non-whitespace characters, sha256={hashlib.sha256(src.encode()).hexdigest()}')
    if a!=b:
        print('ERROR: Lean source outside comments has changed.',file=sys.stderr)
        raise SystemExit(2)
    print('PASS: all Lean code outside comments is byte-identical after whitespace normalization.')

if __name__=='__main__':main()
