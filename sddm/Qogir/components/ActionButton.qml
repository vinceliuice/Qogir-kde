/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

Item {
    id: root
    property alias text: label.text
    property alias iconSource: icon.source
    property alias containsMouse: mouseArea.containsMouse
    property alias font: label.font
    property alias labelRendering: label.renderType
    property alias circleOpacity: iconCircle.opacity
    property alias circleVisiblity: iconCircle.visible
    property int fontSize: config.fontSize
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software
    signal clicked

    activeFocusOnTab: true

    property int iconSize: Kirigami.Units.gridUnit * 3

    implicitWidth: Math.max(iconSize + Kirigami.Units.largeSpacing * 2, label.contentWidth)
    implicitHeight: iconSize + Kirigami.Units.smallSpacing + label.implicitHeight

    opacity: activeFocus || containsMouse ? 1 : 0.85
        Behavior on opacity {
            PropertyAnimation { // OpacityAnimator makes it turn black at random intervals
                duration: Kirigami.Units.longDuration * 2
                easing.type: Easing.InOutQuad
            }
    }

    Rectangle {
        id: iconCircle
        anchors.centerIn: icon
        width: iconSize + Kirigami.Units.smallSpacing
        height: width
        radius: width / 2
        color: softwareRendering ?  Kirigami.Theme.backgroundColor : Kirigami.Theme.textColor
        opacity: activeFocus || containsMouse ? (softwareRendering ? 0.8 : 0.15) : (softwareRendering ? 0.6 : 0)
        Behavior on opacity {
                PropertyAnimation { // OpacityAnimator makes it turn black at random intervals
                    duration: Kirigami.Units.longDuration * 3
                    easing.type: Easing.InOutQuad
                }
        }
    }

    Rectangle {
        anchors.centerIn: iconCircle
        width: iconCircle.width
        height: width
        radius: width / 2
        scale: mouseArea.containsPress ? 1 : 0
        color: Kirigami.Theme.textColor
        opacity: 0.15
        Behavior on scale {
                PropertyAnimation {
                    duration: Kirigami.Units.shortDuration
                    easing.type: Easing.InOutQuart
                }
        }
    }

    Kirigami.Icon {
        id: icon
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        width: iconSize
        height: iconSize

        Kirigami.Theme.colorGroup: Kirigami.Theme.Active
        active: mouseArea.containsMouse || root.activeFocus
    }

    PlasmaComponents.Label {
        id: label
        font.pointSize: Math.max(fontSize + 1,Kirigami.Theme.defaultFont.pointSize + 1)
        anchors {
            top: icon.bottom
            topMargin: (softwareRendering ? 1.5 : 1) * Kirigami.Units.smallSpacing
            left: parent.left
            right: parent.right
        }
        style: softwareRendering ? Text.Outline : Text.Normal
        styleColor: softwareRendering ? Kirigami.Theme.backgroundColor : "transparent" //no outline, doesn't matter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        wrapMode: Text.WordWrap
        font.underline: root.activeFocus
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        onClicked: root.clicked()
        anchors.fill: parent
    }

    Keys.onEnterPressed: clicked()
    Keys.onReturnPressed: clicked()
    Keys.onSpacePressed: clicked()

    Accessible.onPressAction: clicked()
    Accessible.role: Accessible.Button
    Accessible.name: label.text
}
