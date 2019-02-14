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

Your `MAIN` function should **receive** handler and content.

- Handler is passed as string.
- Content is passed as [JSOWN](https://github.com/madnificent/jsown) object.

```lisp
(defun main (handler content)
  ...)
```

### Return value

Your `MAIN` function should **return** [JSOWN](https://github.com/madnificent/jsown) object.

```lisp
(defun main (handler content)
  ...
  '(:obj ("result" . "ok")))
```

Try see `you-should-try-convert-this-script.ros` and convert it.
