import "components"

import QtQuick
import QtQuick.Layouts

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

SessionManagementScreen {
    id: root
    property Item mainPasswordBox: passwordBox

    property bool showUsernamePrompt: !showUserList

    property string lastUserName
    property bool loginScreenUiVisible: false

    //the y position that should be ensured visible when the on screen keyboard is visible
    property int visibleBoundary: mapFromItem(loginButton, 0, 0).y
    onHeightChanged: visibleBoundary = mapFromItem(loginButton, 0, 0).y + loginButton.height + Kirigami.Units.smallSpacing

    property int fontSize: config.fontSize

    signal loginRequest(string username, string password)

    onShowUsernamePromptChanged: {
        if (!showUsernamePrompt) {
            lastUserName = ""
        }
    }

    /*
    * Login has been requested with the following username and password
    * If username field is visible, it will be taken from that, otherwise from the "name" property of the currentIndex
    */
    function startLogin() {
        var username = showUsernamePrompt ? userNameInput.text : userList.selectedUser
        var password = passwordBox.text

        footer.enabled = false
        mainStack.enabled = false
        userListComponent.userList.opacity = 0.5

        //this is partly because it looks nicer
        //but more importantly it works round a Qt bug that can trigger if the app is closed with a TextField focused
        //DAVE REPORT THE FRICKING THING AND PUT A LINK
        loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    PlasmaComponents.TextField {
        id: userNameInput
        font.pointSize: fontSize + 1
        Layout.fillWidth: true

        text: lastUserName
        visible: showUsernamePrompt
        focus: showUsernamePrompt && !lastUserName //if there's a username prompt it gets focus first, otherwise password does
        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Username")

        onAccepted:
            if (root.loginScreenUiVisible) {
                passwordBox.forceActiveFocus()
            }
    }

    RowLayout {
        Layout.fillWidth: true

        PlasmaComponents.TextField {
            id: passwordBox
            font.pointSize: fontSize + 1
            Layout.fillWidth: true

            placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Password")
            focus: !showUsernamePrompt || lastUserName
            echoMode: TextInput.Password
            //revealPasswordButtonShown: false // Disabled whilst SDDM does not have the breeze icon set loaded

            onAccepted: {
                if (root.loginScreenUiVisible) {
                    startLogin();
                }
            }

            Keys.onEscapePressed: {
                mainStack.currentItem.forceActiveFocus();
            }

            //if empty and left or right is pressed change selection in user switch
            //this cannot be in keys.onLeftPressed as then it doesn't reach the password box
            Keys.onPressed: event => {
                if (event.key === Qt.Key_Left && !text) {
                    userList.decrementCurrentIndex();
                    event.accepted = true
                }
                if (event.key === Qt.Key_Right && !text) {
                    userList.incrementCurrentIndex();
                    event.accepted = true
                }
            }

            Connections {
                target: sddm
                function onLoginFailed() {
                    passwordBox.selectAll()
                    passwordBox.forceActiveFocus()
                }
            }
        }

        PlasmaComponents.Button {
            id: loginButton
            Accessible.name: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Log In")
            implicitHeight: passwordBox.height - Kirigami.Units.smallSpacing * 0.5 // otherwise it comes out taller than the password field
            implicitWidth: loginButton.implicitHeight
            Layout.rightMargin: 1 // prevents it from extending beyond the username field

            Kirigami.Icon { // no iconSource because if you take away half a unit (implicitHeight), "go-next" gets cut off
                anchors.fill: parent
                anchors.margins: Kirigami.Units.smallSpacing
                source: "go-next"
            }
            onClicked: startLogin();
        }
    }
}
