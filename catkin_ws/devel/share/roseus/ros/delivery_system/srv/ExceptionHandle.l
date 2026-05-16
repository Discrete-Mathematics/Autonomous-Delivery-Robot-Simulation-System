;; Auto-generated. Do not edit!


(when (boundp 'delivery_system::ExceptionHandle)
  (if (not (find-package "DELIVERY_SYSTEM"))
    (make-package "DELIVERY_SYSTEM"))
  (shadow 'ExceptionHandle (find-package "DELIVERY_SYSTEM")))
(unless (find-package "DELIVERY_SYSTEM::EXCEPTIONHANDLE")
  (make-package "DELIVERY_SYSTEM::EXCEPTIONHANDLE"))
(unless (find-package "DELIVERY_SYSTEM::EXCEPTIONHANDLEREQUEST")
  (make-package "DELIVERY_SYSTEM::EXCEPTIONHANDLEREQUEST"))
(unless (find-package "DELIVERY_SYSTEM::EXCEPTIONHANDLERESPONSE")
  (make-package "DELIVERY_SYSTEM::EXCEPTIONHANDLERESPONSE"))

(in-package "ROS")





(defclass delivery_system::ExceptionHandleRequest
  :super ros::object
  :slots (_error_message ))

(defmethod delivery_system::ExceptionHandleRequest
  (:init
   (&key
    ((:error_message __error_message) "")
    )
   (send-super :init)
   (setq _error_message (string __error_message))
   self)
  (:error_message
   (&optional __error_message)
   (if __error_message (setq _error_message __error_message)) _error_message)
  (:serialization-length
   ()
   (+
    ;; string _error_message
    4 (length _error_message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _error_message
       (write-long (length _error_message) s) (princ _error_message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _error_message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _error_message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass delivery_system::ExceptionHandleResponse
  :super ros::object
  :slots (_confirm_continue ))

(defmethod delivery_system::ExceptionHandleResponse
  (:init
   (&key
    ((:confirm_continue __confirm_continue) nil)
    )
   (send-super :init)
   (setq _confirm_continue __confirm_continue)
   self)
  (:confirm_continue
   (&optional (__confirm_continue :null))
   (if (not (eq __confirm_continue :null)) (setq _confirm_continue __confirm_continue)) _confirm_continue)
  (:serialization-length
   ()
   (+
    ;; bool _confirm_continue
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _confirm_continue
       (if _confirm_continue (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _confirm_continue
     (setq _confirm_continue (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass delivery_system::ExceptionHandle
  :super ros::object
  :slots ())

(setf (get delivery_system::ExceptionHandle :md5sum-) "c329e5e72dfc46d2450f46599776c96c")
(setf (get delivery_system::ExceptionHandle :datatype-) "delivery_system/ExceptionHandle")
(setf (get delivery_system::ExceptionHandle :request) delivery_system::ExceptionHandleRequest)
(setf (get delivery_system::ExceptionHandle :response) delivery_system::ExceptionHandleResponse)

(defmethod delivery_system::ExceptionHandleRequest
  (:response () (instance delivery_system::ExceptionHandleResponse :init)))

(setf (get delivery_system::ExceptionHandleRequest :md5sum-) "c329e5e72dfc46d2450f46599776c96c")
(setf (get delivery_system::ExceptionHandleRequest :datatype-) "delivery_system/ExceptionHandleRequest")
(setf (get delivery_system::ExceptionHandleRequest :definition-)
      "# 请求：异常信息
string error_message        # 异常描述
---
# 响应：人工确认
bool confirm_continue       # 是否继续执行任务

")

(setf (get delivery_system::ExceptionHandleResponse :md5sum-) "c329e5e72dfc46d2450f46599776c96c")
(setf (get delivery_system::ExceptionHandleResponse :datatype-) "delivery_system/ExceptionHandleResponse")
(setf (get delivery_system::ExceptionHandleResponse :definition-)
      "# 请求：异常信息
string error_message        # 异常描述
---
# 响应：人工确认
bool confirm_continue       # 是否继续执行任务

")



(provide :delivery_system/ExceptionHandle "c329e5e72dfc46d2450f46599776c96c")


