#!/bin/bash

(find . -name "*.js" -exec sh -c 'mv "$0" "${0%.js}.ts"' {} \;) & (find . -name "*.jsx" -exec sh -c 'mv "$0" "${0%.jsx}.tsx"' {} \;)

