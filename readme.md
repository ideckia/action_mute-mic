# Action for ideckia: mute-mic

## Definition

Mute / unmute system microphone

## Properties

| Name | Type | Description | Shared | Default | Possible values |
| ----- |----- | ----- | ----- | ----- | ----- |
| mutedIcon | String | Muted icon in base64 | false | null | null |
| mutedColor | String | Muted color | false | 'ffaa0000' | null |
| unmutedIcon | String | Unmuted icon in base64 | false | null | null |
| unmutedColor | String | Unmuted color | false | 'ff00aa00' | null |

## Example in layout file

```json
{
    "state": {
        "text": "mute-mic example",
        "actions": [
            {
                "name": "mute-mic",
                "props": {
                    "mutedIcon": "iVBORw0KGgoAAAANSUhEUgAAAKAAAAFACAYAAAA7/HcbAA.......",
                    "mutedColor": "ffaa0000",
                    "unmutedIcon": "iVBORw0KGgoAAAANSUhEUgAAAKAAAAFACAYAAAA7/HcbAA.......",
                    "unmutedColor": "ff00aa00"
                }
            }
        ]
    }
}
```