
(cl:in-package :asdf)

(defsystem "delivery_system-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ExceptionHandle" :depends-on ("_package_ExceptionHandle"))
    (:file "_package_ExceptionHandle" :depends-on ("_package"))
    (:file "TaskReport" :depends-on ("_package_TaskReport"))
    (:file "_package_TaskReport" :depends-on ("_package"))
  ))