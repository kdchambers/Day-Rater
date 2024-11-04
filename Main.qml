import QtQuick
import QtQuick.Controls
import QtQml
import QtQuick.Layouts
import QtGraphs
import QtQuick.Controls.Material 2.12

Window {
    id: root
    width: Screen.width * 0.7
    height: Screen.height * 0.7
    visible: true
    color: "grey"
    visibility: Window.Maximized
    title: qsTr("DayRater")

    Material.theme: Material.Dark
    Material.accent: Material.LightGreen
    Material.containerStyle: Material.Filled

    property var ratingDescriptions: ["Terrible", "Not Great", "Normal", "Pretty Good", "Amazing"]

    GridLayout {
        id: page_layout
        anchors.fill: parent
        columns: 3
        columnSpacing: 0
        // rowSpacing: 0

        Rectangle {
            id: left_section
            Layout.preferredWidth: 800
            Layout.fillHeight: true
            Layout.columnSpan: 1

            property date currentDate: new Date()

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#4f1d5e" }
                GradientStop { position: 0.33; color: "#1d3f5e" }
                GradientStop { position: 1.0; color: "#5e1d24" }
            }

            GridLayout {
                columns: 3
                anchors.fill: parent
                columnSpacing: 0
                rowSpacing: 0

                Label {
                    id: rate_day_label
                    text: {
                        var dateString = left_section.currentDate.toLocaleDateString();
                        return "Rate " + dateString
                    }

                    font.pixelSize: 32
                    Layout.topMargin: 20
                    Layout.rowSpan: 2
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                }

                Slider {
                    id: rating_slider

                    snapMode: Slider.SnapAlways
                    stepSize: 1.0

                    Layout.preferredWidth: 500
                    Layout.columnSpan: 2
                    Layout.leftMargin: 50

                    from: 1
                    value: 5
                    to: 10
                    live: true
                }

                Label {
                    id: rating_slider_value_label
                    text: rating_slider.value + " (" + root.ratingDescriptions[~~((rating_slider.value - 1) / 2.0)] + ")"

                    Layout.columnSpan: 1
                    Layout.rightMargin: 50
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                }

                TimeSelector {
                    id: wakeup_date_selector
                    label_text: "When did you wake up?"
                    Layout.columnSpan: 3
                    Layout.preferredWidth: 700
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                }

                TimeSelector {
                    id: sleep_date_selector
                    label_text: "When did you go to sleep?"
                    Layout.columnSpan: 3
                    Layout.preferredWidth: 700
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.topMargin: 12
                }

                RowLayout {
                    id: check_boxes_layout
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignHCenter

                    property var min_width: 160

                    ColumnLayout {
                        spacing: 10
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                        CheckBox {
                            Layout.preferredWidth: check_boxes_layout.min_width
                            checked: false
                            text: qsTr("Exercise")
                        }
                        CheckBox {
                            checked: false
                            Layout.preferredWidth: check_boxes_layout.min_width
                            text: qsTr("Menú")
                        }
                        CheckBox {
                            checked: false
                            Layout.preferredWidth: check_boxes_layout.min_width
                            text: qsTr("Spanish Study")
                        }
                    }

                    ColumnLayout {
                        spacing: 10
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        CheckBox {
                            Layout.preferredWidth: check_boxes_layout.min_width
                            checked: false
                            text: qsTr("Coffee")
                        }
                        CheckBox {
                            checked: false
                            Layout.preferredWidth: check_boxes_layout.min_width
                            text: qsTr("Walk")
                        }
                    }

                    ColumnLayout {
                        spacing: 10
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        CheckBox {
                            Layout.preferredWidth: check_boxes_layout.min_width
                            checked: false
                            text: qsTr("Gaming")
                        }
                        CheckBox {
                            Layout.preferredWidth: check_boxes_layout.min_width
                            checked: false
                            text: qsTr("Youtube")
                        }
                    }
                }

                TextArea {
                    id: day_description_text_field
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.topMargin: 10
                    wrapMode: TextEdit.WordWrap
                    Layout.preferredHeight: 180
                    Layout.minimumHeight: 80
                    Layout.maximumHeight: 300
                    placeholderText: qsTr("Describe your day")
                }

                Button {
                    id: submit_rating_button
                    Layout.columnSpan: 3
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 20
                    Layout.topMargin: 10
                    Layout.bottomMargin: 6
                    text: "Submit"
                    onClicked: {
                        console.log("Button clicked")
                        rating_manager.addRating("Blah");
                    }
                }
            }
        }

        Rectangle {
            id: center_section
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 2
            color: "#291936"

            GridLayout {
                id: center_layout
                anchors.fill: parent
                columns: 3
                rows: 3
                columnSpacing: 0

                GraphsView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: 600
                    Layout.minimumHeight: 400
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    theme: GraphsTheme {
                        theme: GraphsTheme.Theme.UserDefined
                        backgroundColor: "#1d302f"
                        // backgroundVisible: true
                        seriesColors: ["#589633"]
                        // colorStyle: GraphsTheme.ColorStyle.Uniform
                        // labelFont.family: "Lucida Handwriting"
                        // labelFont.pointSize: 35
                        // gridVisible: false
                        // grid.mainColor: "red"
                        // grid.subColor: "blue"
                        // labelBackgroundColor: "black"
                        // labelBackgroundVisible: true
                        // labelBorderVisible: false
                        // labelTextColor: "white"
                        // multiHighlightColor: "darkRed"
                        // singleHighlightColor: "darkRed"
                    }
                    // shadowBarWidth: 4
                    shadowColor: "red"

                    axisX: DateTimeAxis {
                        min: new Date(2000,0,1)
                        max: new Date(2000,1,0)
                        labelFormat: "dd-MM"
                    }
                    axisY: ValueAxis {
                        max: 3
                    }

                    LineSeries {
                        // color: "#00ff00"
                        XYPoint { x: new Date(2000,0,1); y: 0.5 }
                        XYPoint { x: new Date(2000,0,2); y: 1 }
                        XYPoint { x: new Date(2000,0,3); y: 2 }
                        XYPoint { x: new Date(2000,0,4); y: 1.5 }
                    }
                }

                Rectangle {
                    id: center_bottom
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: 300
                    Layout.columnSpan: 3
                    Layout.rowSpan: 2
                    color: "#291936"

                    Button {
                        id: settings_button
                        icon.source: "qrc:/icons/assets/icons/dark/settings.svg"
                        icon.width: 32
                        icon.height: 32
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 4
                        anchors.bottomMargin: 4
                        onClicked: {
                            console.log("Icon clicked")
                        }
                        background: Rectangle {
                            color: "black"
                            radius: 4
                            opacity: settings_button.hovered ? 0.1 : 0.0
                        }
                    }
                }
            }
        }
    }
}
