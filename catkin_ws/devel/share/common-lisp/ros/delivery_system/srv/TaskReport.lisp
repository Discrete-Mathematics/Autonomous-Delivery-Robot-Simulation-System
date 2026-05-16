; Auto-generated. Do not edit!


(cl:in-package delivery_system-srv)


;//! \htmlinclude TaskReport-request.msg.html

(cl:defclass <TaskReport-request> (roslisp-msg-protocol:ros-message)
  ((total_time
    :reader total_time
    :initarg :total_time
    :type cl:float
    :initform 0.0)
   (arrived_stations
    :reader arrived_stations
    :initarg :arrived_stations
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (exceptions
    :reader exceptions
    :initarg :exceptions
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass TaskReport-request (<TaskReport-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TaskReport-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TaskReport-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delivery_system-srv:<TaskReport-request> is deprecated: use delivery_system-srv:TaskReport-request instead.")))

(cl:ensure-generic-function 'total_time-val :lambda-list '(m))
(cl:defmethod total_time-val ((m <TaskReport-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:total_time-val is deprecated.  Use delivery_system-srv:total_time instead.")
  (total_time m))

(cl:ensure-generic-function 'arrived_stations-val :lambda-list '(m))
(cl:defmethod arrived_stations-val ((m <TaskReport-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:arrived_stations-val is deprecated.  Use delivery_system-srv:arrived_stations instead.")
  (arrived_stations m))

(cl:ensure-generic-function 'exceptions-val :lambda-list '(m))
(cl:defmethod exceptions-val ((m <TaskReport-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:exceptions-val is deprecated.  Use delivery_system-srv:exceptions instead.")
  (exceptions m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TaskReport-request>) ostream)
  "Serializes a message object of type '<TaskReport-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'total_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'arrived_stations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'arrived_stations))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'exceptions))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'exceptions))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TaskReport-request>) istream)
  "Deserializes a message object of type '<TaskReport-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_time) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'arrived_stations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'arrived_stations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'exceptions) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'exceptions)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TaskReport-request>)))
  "Returns string type for a service object of type '<TaskReport-request>"
  "delivery_system/TaskReportRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TaskReport-request)))
  "Returns string type for a service object of type 'TaskReport-request"
  "delivery_system/TaskReportRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TaskReport-request>)))
  "Returns md5sum for a message object of type '<TaskReport-request>"
  "366d446c5045fee0bf1794916e375414")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TaskReport-request)))
  "Returns md5sum for a message object of type 'TaskReport-request"
  "366d446c5045fee0bf1794916e375414")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TaskReport-request>)))
  "Returns full string definition for message of type '<TaskReport-request>"
  (cl:format cl:nil "# 请求：任务数据~%float32 total_time          # 总耗时（秒）~%string[] arrived_stations   # 成功到达的站点列表~%string[] exceptions         # 异常记录列表~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TaskReport-request)))
  "Returns full string definition for message of type 'TaskReport-request"
  (cl:format cl:nil "# 请求：任务数据~%float32 total_time          # 总耗时（秒）~%string[] arrived_stations   # 成功到达的站点列表~%string[] exceptions         # 异常记录列表~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TaskReport-request>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'arrived_stations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'exceptions) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TaskReport-request>))
  "Converts a ROS message object to a list"
  (cl:list 'TaskReport-request
    (cl:cons ':total_time (total_time msg))
    (cl:cons ':arrived_stations (arrived_stations msg))
    (cl:cons ':exceptions (exceptions msg))
))
;//! \htmlinclude TaskReport-response.msg.html

(cl:defclass <TaskReport-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass TaskReport-response (<TaskReport-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TaskReport-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TaskReport-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delivery_system-srv:<TaskReport-response> is deprecated: use delivery_system-srv:TaskReport-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <TaskReport-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:success-val is deprecated.  Use delivery_system-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <TaskReport-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delivery_system-srv:message-val is deprecated.  Use delivery_system-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TaskReport-response>) ostream)
  "Serializes a message object of type '<TaskReport-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TaskReport-response>) istream)
  "Deserializes a message object of type '<TaskReport-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TaskReport-response>)))
  "Returns string type for a service object of type '<TaskReport-response>"
  "delivery_system/TaskReportResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TaskReport-response)))
  "Returns string type for a service object of type 'TaskReport-response"
  "delivery_system/TaskReportResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TaskReport-response>)))
  "Returns md5sum for a message object of type '<TaskReport-response>"
  "366d446c5045fee0bf1794916e375414")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TaskReport-response)))
  "Returns md5sum for a message object of type 'TaskReport-response"
  "366d446c5045fee0bf1794916e375414")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TaskReport-response>)))
  "Returns full string definition for message of type '<TaskReport-response>"
  (cl:format cl:nil "# 响应：结果~%bool success                # 报告生成是否成功~%string message              # 反馈信息~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TaskReport-response)))
  "Returns full string definition for message of type 'TaskReport-response"
  (cl:format cl:nil "# 响应：结果~%bool success                # 报告生成是否成功~%string message              # 反馈信息~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TaskReport-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TaskReport-response>))
  "Converts a ROS message object to a list"
  (cl:list 'TaskReport-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'TaskReport)))
  'TaskReport-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'TaskReport)))
  'TaskReport-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TaskReport)))
  "Returns string type for a service object of type '<TaskReport>"
  "delivery_system/TaskReport")