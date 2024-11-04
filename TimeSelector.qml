import QtQuick
import QtQuick.Controls

// Item {

    Rectangle {
        id: date_selector_rect
        // x: 50
        // y: 300
        height: 120
        width: 600
        color: "black"
        radius: 10

        property var minute_model: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
        property var hour_model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        property var ampm_model: ["AM", "PM"]
        property var label_text: "Placeholder"

        Label  {
            x: 0
            width: 300
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            // text: "When did you wake up?"
            text: parent.label_text
        }

        Tumbler {
            id: date_selector_tumbler_hour
            model: parent.hour_model

            x: 300
            y: 0

            height: 120
        }

        Tumbler {
            id: date_selector_tumbler_minute
            model: parent.minute_model
            anchors.left: date_selector_tumbler_hour.right
            anchors.leftMargin: 10
            anchors.top: date_selector_tumbler_hour.top
            height: 120
        }

        Tumbler {
            id: date_selector_tumbler_ampm
            model: parent.ampm_model
            anchors.left: date_selector_tumbler_minute.right
            // anchors.leftMargin: 10
            anchors.top: date_selector_tumbler_hour.top

            height: 120
        }

        Label {
            id: date_selector_label
            anchors.left: date_selector_tumbler_ampm.right
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            text: {
                var hour = parent.hour_model[date_selector_tumbler_hour.currentIndex]
                hour = (hour < 9) ? ("0" + hour.toString()) : hour
                var minute = parent.minute_model[date_selector_tumbler_minute.currentIndex]
                minute = (minute < 9) ? ("0" + minute.toString()) : minute
                var ampm = parent.ampm_model[date_selector_tumbler_ampm.currentIndex]
                return hour + ":" + minute + " " + ampm
            }
        }
    }
// }
