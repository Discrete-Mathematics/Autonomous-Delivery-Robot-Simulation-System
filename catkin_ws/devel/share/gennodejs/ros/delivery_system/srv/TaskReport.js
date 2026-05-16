// Auto-generated. Do not edit!

// (in-package delivery_system.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class TaskReportRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.total_time = null;
      this.arrived_stations = null;
      this.exceptions = null;
    }
    else {
      if (initObj.hasOwnProperty('total_time')) {
        this.total_time = initObj.total_time
      }
      else {
        this.total_time = 0.0;
      }
      if (initObj.hasOwnProperty('arrived_stations')) {
        this.arrived_stations = initObj.arrived_stations
      }
      else {
        this.arrived_stations = [];
      }
      if (initObj.hasOwnProperty('exceptions')) {
        this.exceptions = initObj.exceptions
      }
      else {
        this.exceptions = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TaskReportRequest
    // Serialize message field [total_time]
    bufferOffset = _serializer.float32(obj.total_time, buffer, bufferOffset);
    // Serialize message field [arrived_stations]
    bufferOffset = _arraySerializer.string(obj.arrived_stations, buffer, bufferOffset, null);
    // Serialize message field [exceptions]
    bufferOffset = _arraySerializer.string(obj.exceptions, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TaskReportRequest
    let len;
    let data = new TaskReportRequest(null);
    // Deserialize message field [total_time]
    data.total_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [arrived_stations]
    data.arrived_stations = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [exceptions]
    data.exceptions = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.arrived_stations.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    object.exceptions.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'delivery_system/TaskReportRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '02467ad323c5ac2c77cac6918145f45d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 请求：任务数据
    float32 total_time          # 总耗时（秒）
    string[] arrived_stations   # 成功到达的站点列表
    string[] exceptions         # 异常记录列表
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TaskReportRequest(null);
    if (msg.total_time !== undefined) {
      resolved.total_time = msg.total_time;
    }
    else {
      resolved.total_time = 0.0
    }

    if (msg.arrived_stations !== undefined) {
      resolved.arrived_stations = msg.arrived_stations;
    }
    else {
      resolved.arrived_stations = []
    }

    if (msg.exceptions !== undefined) {
      resolved.exceptions = msg.exceptions;
    }
    else {
      resolved.exceptions = []
    }

    return resolved;
    }
};

class TaskReportResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TaskReportResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TaskReportResponse
    let len;
    let data = new TaskReportResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.message);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'delivery_system/TaskReportResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '937c9679a518e3a18d831e57125ea522';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 响应：结果
    bool success                # 报告生成是否成功
    string message              # 反馈信息
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TaskReportResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: TaskReportRequest,
  Response: TaskReportResponse,
  md5sum() { return '366d446c5045fee0bf1794916e375414'; },
  datatype() { return 'delivery_system/TaskReport'; }
};
