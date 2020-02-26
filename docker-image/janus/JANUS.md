# JANUS APIs

BaseUrl: {url}/janus  <br />

## 1. Create Session

​	**Url**: {BaseUrl}  <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "create",
    "transaction": "<random alphanumeric string>"
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />
```json
{
    "janus": "success",
    "transaction": "<same as request transaction string>",
    "data": {
        "id": "<integer session-id>"
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "create",
    "transaction": "1qa32e3r4e5t"
}
```

</br>

## 2. Start Stream Plugin

​	**Url**: {BaseUrl}   <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "attach",
    "session_id": "<integer session-id>",
    "plugin": "janus.plugin.streaming",
    "transaction": "<random alphanumeric string>"
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />

```json
{
    "janus": "success",
    "transaction": "<same as request transaction string>",
    "data": {
        "id": "<integer plugin-id>"
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "attach",
    "session_id": "1234567890",
    "plugin": "janus.plugin.streaming",
    "transaction": "1qa32e3r4e5t"
}
```

</br>

## 3. Delete session

​	**Note**: Delete plugins before deleting session

​	**Url**: {BaseUrl}   <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "destroy",
    "session_id": "<integer session-id>",
    "transaction": "<random alphanumeric string>"
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />

```json
{
    "janus": "success",
    "transaction": "<same as request transaction string>",
    "data": {
        "id": "<integer plugin-id>"
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "destroy",
    "session_id": "12346790"
    "transaction": "1qa32e3r4e5t"
}
```

</br>

# Stream Synchronous APIs

## 1. List available streams

​	**Url**: {BaseUrl} <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "messsage",
    "session_id": "<integer session-id>",
    "handle_id": "<integer plugin-id>",
    "transaction": "<random alphanumeric string>",
    "body": {
        "request": "list"
    }
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />

```json
{
    "janus": "success",
    "session_id": "<integer session-id>",
    "sender": "<integer plugin-id>",
    "transaction": "<same as request transaction string>",
    "plugindata": {
        "plugin": "janus.plugin.streaming",
        "data": {
            "streaming": "list",
            "list": [
                {
                    "id": 1,
                    "description": "Fashion Store ABC Stream",
                    "type": "live",
                    "audio_age_ms": 12,
                    "video_age_ms": 6
                },
                {
                    "id": 2,
                    "description": "Makeup Store ABC Stream",
                    "type": "live",
                    "audio_age_ms": 10,
                    "video_age_ms": 4
                }
            ]
        }
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "messsage",
    "session_id": "123457890",
    "handle_id": "09865421"
    "transaction": "234rt789io",
    "body": {
        "request": "list"
    }
}
```

</br>

## 2. Stream info

​	**Url**: {BaseUrl} <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "messsage",
    "session_id": "<integer session-id>",
    "handle_id": "<integer plugin-id>",
    "transaction": "<random alphanumeric string>",
    "body": {
        "request": "info",
        "id": <stream id>
    }
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />

```json
{
    "janus": "success",
    "session_id": "<integer session-id>",
    "sender": "<integer plugin-id>",
    "transaction": "<same as request transaction string>",
    "plugindata": {
        "plugin": "janus.plugin.streaming",
        "data": {
            "streaming": "info",
            "info": {
                "id": <stream id>,
                "name": <stream unique name>,
                "description": <stream description>,
                ...
            }
        }
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "messsage",
    "session_id": "123457890",
    "handle_id": "09865421"
    "transaction": "234rt789io",
    "body": {
        "request": "info",
        "id": 1
    }
}
```

</br>

## 3. Create Stream

​	**Url**: {BaseUrl} <br />

​	**Method**: POST  <br />

​	**Request Body**:  <br />

```json
{
	"janus": "messsage",
    "session_id": "<integer session-id>",
    "handle_id": "<integer plugin-id>",
    "transaction": "<random alphanumeric string>",
    "body": {
        "request": "create",
        "type": "live" ,
        "id": "<optional, random by server if missing>",
        "name": "<optional, random by server if missing>",
        "description": "<optional>",
        "secret": "<optional>",
        "pin": "<optional>",
        "is_private": false,
        "audio": true,
        "video": true,
        "data": false,
        "permanent": false
    }
}
```

​	**Success Response**: <br />

​		**Code**: 200 <br />

​		**Body**:  <br />

```json
{
    "janus": "success",
    "session_id": "<integer session-id>",
    "sender": "<integer plugin-id>",
    "transaction": "<same as request transaction string>",
    "plugindata": {
        "plugin": "janus.plugin.streaming",
        "data": {
            "streaming": "created",
            "create": <name of stream>,
            "permanent": false,
            "streaming": {
            	"id": "<stream id>",
            	"type": "<stream-type>",
            	"description": "<stream description>",
            	"is_private": false,
            	...
        	}
        }
    }
}
```

​	**Sample Call**: <br />

```json
{
	"janus": "messsage",
    "session_id": "123457890",
    "handle_id": "09865421"
    "transaction": "234rt789io",
    "body": {
        "request": "info",
        "id": 1
    }
}
```

</br>

## 4. Edit Stream

## 5. Delete Stream

## 6. Enable Stream

## 7. Disable Stream

