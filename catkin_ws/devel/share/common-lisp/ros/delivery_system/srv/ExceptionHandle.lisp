; Auto-generated. Do not edit!


(cl:in-package delivery_system-srv)


;//! \htmlinclude ExceptionHandle-request.msg.html

(cl:defclass <ExceptionHandle-request> (roslisp-msg-protocol:ros-message)
  ((error_message
    :reader error_message
    :initarg :error_message
    :type cl:string
    :initform ""))
)

(cl:defclass ExceptionHandle-request (<ExceptionHandle-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExceptionHandle-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExceptionHandle-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delivery_system-srv:<ExceptionHandle-request> is deprecated: use delivery_system-srv:ExceptionHandle-request instead.")))

(cl:ensure-generic-function 'error_message-val :lambda-list '(m))
(cl:defmethod error_message-val ((m <ExceptionHandle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:error_message-val is deprecated.  Use delivery_system-srv:error_message instead.")
  (error_message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExceptionHandle-request>) ostream)
  "Serializes a message object of type '<ExceptionHandle-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'error_message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'error_message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExceptionHandle-request>) istream)
  "Deserializes a message object of type '<ExceptionHandle-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'error_message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExceptionHandle-request>)))
  "Returns string type for a service object of type '<ExceptionHandle-request>"
  "delivery_system/ExceptionHandleRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionHandle-request)))
  "Returns string type for a service object of type 'ExceptionHandle-request"
  "delivery_system/ExceptionHandleRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExceptionHandle-request>)))
  "Returns md5sum for a message object of type '<ExceptionHandle-request>"
  "c329e5e72dfc46d2450f46599776c96c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExceptionHandle-request)))
  "Returns md5sum for a message object of type 'ExceptionHandle-request"
  "c329e5e72dfc46d2450f46599776c96c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExceptionHandle-request>)))
  "Returns full string definition for message of type '<ExceptionHandle-request>"
  (cl:format cl:nil "# 请求：异常信息~%string error_message        # 异常描述~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExceptionHandle-request)))
  "Returns full string definition for message of type 'ExceptionHandle-request"
  (cl:format cl:nil "# 请求：异常信息~%string error_message        # 异常描述~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExceptionHandle-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'error_message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExceptionHandle-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ExceptionHandle-request
    (cl:cons ':error_message (error_message msg))
))
;//! \htmlinclude ExceptionHandle-response.msg.html

(cl:defclass <ExceptionHandle-response> (roslisp-msg-protocol:ros-message)
  ((confirm_continue
    :reader confirm_continue
    :initarg :confirm_continue
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ExceptionHandle-response (<ExceptionHandle-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExceptionHandle-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExceptionHandle-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delivery_system-srv:<ExceptionHandle-response> is deprecated: use delivery_system-srv:ExceptionHandle-response instead.")))

(cl:ensure-generic-function 'confirm_continue-val :lambda-list '(m))
(cl:defmethod confirm_continue-val ((m <ExceptionHandle-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:confirm_continue-val is deprecated.  Use delivery_system-srv:confirm_continue instead.")
  (confirm_continue m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExceptionHandle-response>) ostream)
  "Serializes a message object of type '<ExceptionHandle-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'confirm_continue) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExceptionHandle-response>) istream)
  "Deserializes a message object of type '<ExceptionHandle-response>"
    (cl:setf (cl:slot-value msg 'confirm_continue) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExceptionHandle-response>)))
  "Returns string type for a service object of type '<ExceptionHandle-response>"
  "delivery_system/ExceptionHandleResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionHandle-response)))
  "Returns string type for a service object of type 'ExceptionHandle-response"
  "delivery_system/ExceptionHandleResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExceptionHandle-response>)))
  "Returns md5sum for a message object of type '<ExceptionHandle-response>"
  "c329e5e72dfc46d2450f46599776c96c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExceptionHandle-response)))
  "Returns md5sum for a message object of type 'ExceptionHandle-response"
  "c329e5e72dfc46d2450f46599776c96c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExceptionHandle-response>)))
  "Returns full string definition for message of type '<ExceptionHandle-response>"
  (cl:format cl:nil "# 响应：人工确认~%bool confirm_continue       # 是否继续执行任务~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExceptionHandle-response)))
  "Returns full string definition for message of type 'ExceptionHandle-response"
  (cl:format cl:nil "# 响应：人工确认~%bool confirm_continue       # 是否继续执行任务~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExceptionHandle-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExceptionHandle-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ExceptionHandle-response
    (cl:cons ':confirm_continue (confirm_continue msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ExceptionHandle)))
  'ExceptionHandle-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ExceptionHandle)))
  'ExceptionHandle-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExceptionHandle)))
  "Returns string type for a service object of type '<ExceptionHandle>"
  "delivery_system/ExceptionHandle")