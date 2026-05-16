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

class ExceptionHandleRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.error_message = null;
    }
    else {
      if (initObj.hasOwnProperty('error_message')) {
        this.error_message = initObj.error_message
      }
      else {
        this.error_message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExceptionHandleRequest
    // Serialize message field [error_message]
    bufferOffset = _serializer.string(obj.error_message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExceptionHandleRequest
    let len;
    let data = new ExceptionHandleRequest(null);
    // Deserialize message field [error_message]
    data.error_message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.error_message);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'delivery_system/ExceptionHandleRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a13979422fc129b30b15994450a302b5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 请求：异常信息
    string error_message        # 异常描述
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExceptionHandleRequest(null);
    if (msg.error_message !== undefined) {
      resolved.error_message = msg.error_message;
    }
    else {
      resolved.error_message = ''
    }

    return resolved;
    }
};

class ExceptionHandleResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.confirm_continue = null;
    }
    else {
      if (initObj.hasOwnProperty('confirm_continue')) {
        this.confirm_continue = initObj.confirm_continue
      }
      else {
        this.confirm_continue = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExceptionHandleResponse
    // Serialize message field [confirm_continue]
    bufferOffset = _serializer.bool(obj.confirm_continue, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExceptionHandleResponse
    let len;
    let data = new ExceptionHandleResponse(null);
    // Deserialize message field [confirm_continue]
    data.confirm_continue = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'delivery_system/ExceptionHandleResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9c7c513c4506e8c5d9151c84ecc9ad42';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 响应：人工确认
    bool confirm_continue       # 是否继续执行任务
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExceptionHandleResponse(null);
    if (msg.confirm_continue !== undefined) {
      resolved.confirm_continue = msg.confirm_continue;
    }
    else {
      resolved.confirm_continue = false
    }

    return resolved;
    }
};

module.exports = {
  Request: ExceptionHandleRequest,
  Response: ExceptionHandleResponse,
  md5sum() { return 'c329e5e72dfc46d2450f46599776c96c'; },
  datatype() { return 'delivery_system/ExceptionHandle'; }
};
