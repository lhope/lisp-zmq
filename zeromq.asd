
(cl:eval-when (:load-toplevel :execute)
  (asdf:operate 'asdf:load-op 'cffi-grovel))

(defsystem zeromq
  :name "zeromq"
  :version "1.0.0"
  :author "Nicolas Martyanoff"
  :license "BSD"
  :description "A binding of the zeromq transport layer."
  :depends-on (:cffi)
  :in-order-to ((test-op (load-op zeromq-test)))
  :components ((:module "src" :components ((:file "packages")
                                           (cffi-grovel:grovel-file "grovel"
                                                                    :depends-on ("packages"))
                                           (:file "ffi" :depends-on ("packages" "grovel"))
                                           (:file "zeromq" :depends-on ("ffi"))))))

(defmethod perform ((o asdf:test-op) (c (eql (find-system :zeromq))))
  (funcall (intern "RUN!" :5am)
           (intern "MAIN" :zeromq-test)))