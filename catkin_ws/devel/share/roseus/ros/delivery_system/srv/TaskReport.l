;; Auto-generated. Do not edit!


(when (boundp 'delivery_system::TaskReport)
  (if (not (find-package "DELIVERY_SYSTEM"))
    (make-package "DELIVERY_SYSTEM"))
  (shadow 'TaskReport (find-package "DELIVERY_SYSTEM")))
(unless (find-package "DELIVERY_SYSTEM::TASKREPORT")
  (make-package "DELIVERY_SYSTEM::TASKREPORT"))
(unless (find-package "DELIVERY_SYSTEM::TASKREPORTREQUEST")
  (make-package "DELIVERY_SYSTEM::TASKREPORTREQUEST"))
(unless (find-package "DELIVERY_SYSTEM::TASKREPORTRESPONSE")
  (make-package "DELIVERY_SYSTEM::TASKREPORTRESPONSE"))

(in-package "ROS")





(defclass delivery_system::TaskReportRequest
  :super ros::object
  :slots (_total_time _arrived_stations _exceptions ))

(defmethod delivery_system::TaskReportRequest
  (:init
   (&key
    ((:total_time __total_time) 0.0)
    ((:arrived_stations __arrived_stations) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:exceptions __exceptions) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _total_time (float __total_time))
   (setq _arrived_stations __arrived_stations)
   (setq _exceptions __exceptions)
   self)
  (:total_time
   (&optional __total_time)
   (if __total_time (setq _total_time __total_time)) _total_time)
  (:arrived_stations
   (&optional __arrived_stations)
   (if __arrived_stations (setq _arrived_stations __arrived_stations)) _arrived_stations)
  (:exceptions
   (&optional __exceptions)
   (if __exceptions (setq _exceptions __exceptions)) _exceptions)
  (:serialization-length
   ()
   (+
    ;; float32 _total_time
    4
    ;; string[] _arrived_stations
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _arrived_stations)) 4
    ;; string[] _exceptions
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _exceptions)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _total_time
       (sys::poke _total_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string[] _arrived_stations
     (write-long (length _arrived_stations) s)
     (dolist (elem _arrived_stations)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _exceptions
     (write-long (length _exceptions) s)
     (dolist (elem _exceptions)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _total_time
     (setq _total_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string[] _arrived_stations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _arrived_stations (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _arrived_stations i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _exceptions
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _exceptions (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _exceptions i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass delivery_system::TaskReportResponse
  :super ros::object
  :slots (_success _message ))

(defmethod delivery_system::TaskReportResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass delivery_system::TaskReport
  :super ros::object
  :slots ())

(setf (get delivery_system::TaskReport :md5sum-) "366d446c5045fee0bf1794916e375414")
(setf (get delivery_system::TaskReport :datatype-) "delivery_system/TaskReport")
(setf (get delivery_system::TaskReport :request) delivery_system::TaskReportRequest)
(setf (get delivery_system::TaskReport :response) delivery_system::TaskReportResponse)

(defmethod delivery_system::TaskReportRequest
  (:response () (instance delivery_system::TaskReportResponse :init)))

(setf (get delivery_system::TaskReportRequest :md5sum-) "366d446c5045fee0bf1794916e375414")
(setf (get delivery_system::TaskReportRequest :datatype-) "delivery_system/TaskReportRequest")
(setf (get delivery_system::TaskReportRequest :definition-)
      "# 请求：任务数据
float32 total_time          # 总耗时（秒）
string[] arrived_stations   # 成功到达的站点列表
string[] exceptions         # 异常记录列表
---
# 响应：结果
bool success                # 报告生成是否成功
string message              # 反馈信息

")

(setf (get delivery_system::TaskReportResponse :md5sum-) "366d446c5045fee0bf1794916e375414")
(setf (get delivery_system::TaskReportResponse :datatype-) "delivery_system/TaskReportResponse")
(setf (get delivery_system::TaskReportResponse :definition-)
      "# 请求：任务数据
float32 total_time          # 总耗时（秒）
string[] arrived_stations   # 成功到达的站点列表
string[] exceptions         # 异常记录列表
---
# 响应：结果
bool success                # 报告生成是否成功
string message              # 反馈信息

")



(provide :delivery_system/TaskReport "366d446c5045fee0bf1794916e375414")


