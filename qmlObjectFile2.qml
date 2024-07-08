import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import fromCpp.initialLoader 1.0
import Constants 1.0

import "../../../customPrimitives"
import GlobalConstants 1.0

CustomPopUp {
    id: popup
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    y:fullHDScale(-150)

    contentItem:Rectangle{
        id:objPopUpRect
        objectName: "objPopUpRect"
        anchors.fill: parent
        implicitHeight: fullHDScale(125)
        implicitWidth: fullHDScale(248)
        color: Constants.objColorProperties.m_303030Color
        border.color: Constants.objColorProperties.m_474747Color
        border.width: 1

        Component {
            id: objMainPopUp

            Column {
                anchors.top: parent.top
                anchors.topMargin: fullHDScale(15)
                spacing: fullHDScale(2)

                Rectangle{
                    id : objOverwriteRect
                    objectName: "objOverwriteRect"
                    width: fullHDScale(248)
                    height: fullHDScale(28)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: bHover && enabled? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
                    property bool bHover: false

                    CustomText{
                        id: objDestGrpOverwrite
                        objectName: "objDestGrpOverwrite"
                        text: Constants.objStaticKey.strOverwrite + " " + Constants.objStaticKey.strGroup
                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
                        opacity: enabled ? 1 : 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            parent.bHover = !parent.bHover
                        }
                        onClicked: {
                            if(objSysCollUi.m_DestGroupCollectionUi)
                                objSysCollUi.m_DestGroupCollectionUi.qmlOverwriteGroup(iSelectedGroupXmlId)
                            popup.close()
                        }
                    }

                }

                Rectangle{
                    id : objDeleteDestGroupRect
                    objectName: "objDeleteDestGroupRect"
                    width: fullHDScale(248)
                    height: fullHDScale(28)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: bHover ? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
                    property bool bHover: false

                    CustomText{
                        id: objDestGrpDelete
                        objectName: "objDestGrpDelete"
                        text: Constants.objStaticKey.strDelete + " " + Constants.objStaticKey.strGroup
                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
                        opacity: 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)


                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            parent.bHover = !parent.bHover
                        }
                        onClicked: {
                            if(objSysCollUi.m_DestGroupCollectionUi)
                                objSysCollUi.m_DestGroupCollectionUi.qmlRemoveGroup(iSelectedGroupXmlId)
                            iSelectedGroup = -1
                        }
                    }

                }

                Rectangle{
                    id : objDuplicateRect12345
                    objectName: "objDuplicateRect"
                    width: fullHDScale(248)
                    height: fullHDScale(28)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: bHover && enabled ? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
                    property bool bHover: false

                    CustomText{
                        id: objDestGrpDuplicate
                        objectName: "objDestGrpDuplicateChanged"
                        text: qsTr("Duplicate") + ctxWindowsMgrUi.emptyString + " " + Constants.objStaticKey.strGroup
                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
                        opacity: enabled ? 1 : 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)


                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            parent.bHover = !parent.bHover
                        }
                        onClicked: {
                            if(objSysCollUi.m_DestGroupCollectionUi) {
                                objSysCollUi.m_DestGroupCollectionUi.qmlAddGroup(objDestGroup.getXmlId(), true)
                                objSysCollUi.m_objDestMgrUi.qmlApplyDestGroup(objDestGroup.getXmlId())
                            }
                            popup.close()
                        }
                    }

                }

                Rectangle{
                    id : objRenameRect
                    objectName: "objRenameRectChanged"
                    width: fullHDScale(248)
                    height: fullHDScale(28)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: bHover ? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
                    property bool bHover: false

                    CustomText{
                        id: objDestGrpRename
                        objectName: "objDestGrpRename"
                        text: Constants.objStaticKey.strRename + " " + Constants.objStaticKey.strGroup
                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
                        opacity: 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)


                    }
					CustomText{
                        id: NewIdNotPresentBefore
                        objectName: "NewobjNotPresentBefore"
                        text: Constants.objStaticKey.strRename + " " + Constants.objStaticKey.strGroup
                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
                        opacity: 1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)


                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            parent.bHover = !parent.bHover
                        }
                        onClicked: {                            
                            popup.close()
                            objDestGroupText.enableEditor()
                        }
                    }

                }


// Below features will be added in 2nd release.
//                Item {
//                    height: fullHDScale(10)
//                    width: parent.width
//                }

//                CustomSeparator {
//                    width: parent.width
//                    color: Constants.objColorProperties.m_474747Color
//                }

//                Item {
//                    height: fullHDScale(10)
//                    width: parent.width
//                }

//                Rectangle{
//                    id : objMoveLeftRect
//                    objectName: "objMoveLeftRect"
//                    width: fullHDScale(248)
//                    height: fullHDScale(28)
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    color: bHover ? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
//                    property bool bHover: false
//                    enabled: false

//                    CustomText{
//                        id: objDestGrpLeft
//                        objectName: "objDestGrpLeft"
//                        text: qsTr("Move Left") + ctxWindowsMgrUi.emptyString
//                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
//                        opacity: 0.5
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.left: parent.left
//                        anchors.leftMargin: fullHDScale(10)


//                    }
//                    MouseArea{
//                        anchors.fill: parent
//                        hoverEnabled: true
//                        onHoveredChanged: {
//                            parent.bHover = !parent.bHover
//                        }
//                    }

//                }


//                Rectangle{
//                    id : objMoveRightRect
//                    objectName: "objMoveRightRect"
//                    width: fullHDScale(248)
//                    height: fullHDScale(28)
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    color: bHover ? Constants.objColorProperties.str0A8CE9Color : Constants.objColorProperties.m_transparentColor
//                    property bool bHover: false
//                    enabled: false

//                    CustomText{
//                        id: objDestGrpRight
//                        objectName: "objDestGrpRight"
//                        text: qsTr("Move Right") + ctxWindowsMgrUi.emptyString
//                        font.pixelSize: fullHDScale(Constants.objStaticValue.m_iMediumFontSize)
//                        opacity: 0.5
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.left: parent.left
//                        anchors.leftMargin: fullHDScale(10)


//                    }
//                    MouseArea{
//                        anchors.fill: parent
//                        hoverEnabled: true
//                        onHoveredChanged: {
//                            parent.bHover = !parent.bHover
//                        }
//                    }

//                }
            }

        }

    }

    CustomLoader{
        id: objLoader
        objectName: "objLoader"
        anchors.fill: parent
        sourceComponent : objMainPopUp
    }

}
