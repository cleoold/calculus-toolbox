#lang scheme/base

(require "cal-tool.scm")

(with-handlers ((exn:fail:contract?
                 (lambda (e) (display "CONTRACT FAIL: check inputs are according to the format and try again.\n\n")
                   (display "the programme is recovered from a contract failure error.\n")
                   (display "report the error if your input was correct.\n")
                   (caltool-main)))
                (exn:fail:syntax?
                 (lambda (e) (display "SYNTAX FAIL: be sure the variables are precisely as required.\n\n")
                   (display "the programme is recovered from a syntax failure error.\n")
                   (caltool-main)))
                (exn:fail:read?
                 (lambda (e) (display "READ FAIL: note enclosing brackets and prefix notion.\n\n")
                   (display "the programme is recovered from a read failure error.\n")
                   (caltool-main))))
(caltool-main))