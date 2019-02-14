# lambda-over-lambda
Roswell (Common Lisp) script into AWS Lambda converter

ALPHA QUALITY: Interfaces can be changed.

## Prerequistes

- [roswell](https://github.com/roswell/roswell) (common lisp implementation manager)
- docker (container tool)
- docker-compose (container orchestration tool)
- make (build tool)
- zip

## Install

Use ros command or clone this repository manually.

_TODO: quicklisp_

```shell
ros install windymelt/lambda-over-lambda
```

## Usage

```shell
% lambda-over-lambda script-to-convert.ros
=> you will get out.zip (overwritten)
```

You can get help by `./roswell/lambda-over-lambda.ros` without any arguments.

## Interface

### Arguments

Your `MAIN` function should **receive** handler and event object.

- Handler is passed as string.
- Event is passed as [JSOWN](https://github.com/madnificent/jsown) object.
  - `true` is translated into `t`.
  - **`false` is translated into `:f`.**
  - `null` is translated into `:null`.
  - `[]` is translated into `nil`.

```lisp
(defun main (handler event)
  ...)
```

### Return value

Your `MAIN` function should **return** [JSOWN](https://github.com/madnificent/jsown) object.

```lisp
(defun main (handler event)
  ...
  '(:obj ("result" . "ok")))
```

Try see `you-should-try-convert-this-script.ros` and convert it.
