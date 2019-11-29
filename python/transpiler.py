import phply # to parse PHP
import pyjsparser #to parse JavaScript
import luaparser # to parse Lua
import pycparser # to parse C

import rpython #to translate Python to C
import jiphy
import transcrypt # to translate Python to JavaScript

from pampy import match, HEAD, TAIL, _

def fibonacci(n):
    return match(n,
        1, 1,
        2, 1,
        _, lambda x: fibonacci(x-1) + fibonacci(x-2)
    )

print(fibonacci(3))

x = [1, 2, 3]

print(match([1], [1, TAIL],     lambda t: t))            # => [2, 3]

print(match([1], [HEAD, TAIL],  lambda h, t: (h, t)))    # => (1, [2, 3])
