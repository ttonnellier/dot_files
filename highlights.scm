;;
;; Keywords
;; ========
;;
[
  "access"
  "after"
  "alias"
  "architecture"
  "attribute"
  "begin"
  "block"
  "body"
  "buffer"
  "bus"
  "component"
  "configuration"
  "const"
  "cover"
  "default"
  "end"
  "entity"
  "force"
  "generate"
  "group"
  "guarded"
  "hdltype"
  "in"
  "inertial"
  "inout"
  "is"
  "label"
  "linkage"
  "literal"
  "next"
  "of"
  "on"
  "out"
  "package"
  "postponed"
  "protected"
  "register"
  "reject"
  "release"
  "shared"
  "transport"
  "units"
  "vmode"
  "vprop"
  "vunit"
  "generic"
  "port"
  "map"
  "type"
  "subtype"
] @keyword

[
  "constant"
  "signal"
  "variable"
  "file"
  "array"
  "record"
] @type

[
  "for"
  "loop"
  "while"
  "exit"
  "forall"
  "sequence"
  "range"
  "downto"
  "to"
] @repeat

[
  "?"
  "case"
  "disconnect"
  "else"
  "elsif"
  "if"
  "property"
  "select"
  "then"
  "wait"
  "when"
  "with"
] @conditional

[
  "assert"
  "assume"
  "assume_guarantee"
  "report"
  "severity"
  "restrict"
  "restrict_guarantee"
  "strong"
  "fairness"
] @exception

[
  "library"
  "use"
  "context"
] @include

[
  "function"
  "impure"
  "parameter"
  "procedure"
  "pure"
  "return"
  "process"
] @keyword.function

;;
;; Punctuations
;; ========
;;
[
  ":"
  "|"
  ","
  "."
  ";"
  "'"
  "@"
  "^."
  "/"
  (semicolon)
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "<<"
  ">>"
] @punctuation.bracket

;;
;; Operators
;; =========
;;
[
  "and"
  "or"
  "nand"
  "nor"
  "xor"
  "xnor"
  "sll"
  "srl"
  "sla"
  "sra"
  "rol"
  "ror"
  "mod"
  "rem"
  "abs"
  "not"
  "new"
  "always"
  "never"
  "eventually"
  "next_a"
  "next_event"
  "next_event_a"
  "next_event_e"
  "async_abort"
  "sync_abort"
  "abort"
  "before"
  "within"
] @keyword.operator

[
  ":="
  "=>"
  "??"
  "="
  "/="
  "<"
  "<="
  ">"
  ">="
  "?="
  "?/="
  "?<"
  "?<="
  "?>"
  "?>="
  "+"
  "-"
  "&"
  "*"
  "/"
  "**"
  "->"
  "<->"
  "&&"
  "!"
  "|=>"
  "|->"
] @operator

(PSL_Bounding_FL_Property
  "_" @operator)

(PSL_Clock_Declaration
  "clock" @keyword)

[
  "all"
  "open"
  "others"
  "null"
  "unaffected"
  "inherit"
  (any)
  (same)
] @constant.macro

;;
;; Literals
;; ========
;;
[
  (integer_decimal)
  (based_integer)
] @number

[
  (real_decimal)
  (based_real)
] @float

(string_literal) @string

(bit_string_literal) @string.special

[
  (physical_literal)
  (character_literal)
] @character

;;
;; Others
;; ======
;;
(comment) @comment

(ERROR) @ERROR

(predefined_designator) @attribute
