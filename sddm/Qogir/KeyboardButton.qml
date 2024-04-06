import QtQuick

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents

import org.kde.kirigami 2.20 as Kirigami

PlasmaComponents.ToolButton {
    id: keyboardButton

    property int currentIndex: -1

    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Keyboard Layout: %1", instantiator.objectAt(currentIndex).shortName)
    //implicitWidth: minimumWidth
    font.pointSize: config.fontSize

    visible: keyboard.layouts.length > 1

    Component.onCompleted: currentIndex = Qt.binding(function() {return keyboard.currentLayout});

    checkable: true
    checked: keyboardMenu.opened
    onToggled: {
        if (checked) {
            keyboardMenu.popup(keyboardButton, 0, 0)
        } else {
            keyboardMenu.dismiss()
        }
    }

    PlasmaComponents.Menu {
        id: keyboardMenu
        Kirigami.Theme.colorSet: Kirigami.Theme.Window
        Kirigami.Theme.inherit: false

        Instantiator {
            id: instantiator
            model: keyboard.layouts
            onObjectAdded: (index, object) => keyboardMenu.insertItem(index, object)
            onObjectRemoved: (index, object) => keyboardMenu.removeItem(object)
            delegate: PlasmaComponents.MenuItem {
                text: modelData.longName
                property string shortName: modelData.shortName
                onTriggered: {
                    keyboard.currentLayout = model.index
                }
            }
        }
    }
}
