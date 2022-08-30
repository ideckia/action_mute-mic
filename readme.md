# Action for [ideckia](https://ideckia.github.io/): mute-mic

## Definition

Mute / unmute system microphone

## Properties

| Name | Type | Description | Shared | Default | Possible values |
| ----- |----- | ----- | ----- | ----- | ----- |
| muted_icon | String | Muted icon in base64 | false | null | null |
| muted_color | String | Muted color | false | 'ffaa0000' | null |
| unmuted_icon | String | Unmuted icon in base64 | false | null | null |
| unmuted_color | String | Unmuted color | false | 'ff00aa00' | null |

## Example in layout file

```json
{
    "state": {
        "text": "mute-mic example",
        "actions": [
            {
                "name": "mute-mic",
                "props": {
                    "muted_icon": "iVBORw0KGgoAAAANSUhEUgAAAKAAAAFACAYAAAA7/HcbAA.......",
                    "muted_color": "ffaa0000",
                    "unmuted_icon": "iVBORw0KGgoAAAANSUhEUgAAAKAAAAFACAYAAAA7/HcbAA.......",
                    "unmuted_color": "ff00aa00"
                }
            }
        ]
    }
}
```

## Credits

Windows aplication C++ code modified from [rdp](https://gist.github.com/rdp/8363580)
