import QtQuick 2.15
import QtQuick.Controls 2.5
import Constants 1.0
import GlobalConstants 1.0
import fromCpp.initialLoader 1.0

import "../../../customPrimitives"
import "../../../customPrimitives/barcoComboBox"

Rectangle {
    id: objBGBaseRoot
    objectName: "objBGBaseRoot"

    property QtObject objBGLayerUi: null
    property QtObject objColorUi : objBGLayerUi
                                   ? objBGLayerUi.colourUi
                                   : null
    property QtObject objSourceUi: null

    property QtObject objFirstDestOpMapUi: objScrDestAreaRoot.destOpMapCollUi ? objScrDestAreaRoot.destOpMapCollUi.firstDestOpMapUi : null
    property QtObject objToggleMode: objFirstDestOpMapUi ? objFirstDestOpMapUi.toggleMode : null
    property bool iShowMatte: objBGLayerUi ? !objBGLayerUi.showMatte.value : true

    onIShowMatteChanged: {
        if(iShowMatte === false && objBGLayerUi) {
            objBGLayerUi.qmlSetHPos(0)
            objBGLayerUi.qmlSetVPos(0)
        }
    }

    property string szSourceName: objBGLayerUi && !objBGLayerUi.showMatte.value
                                    ? objBGLayerUi.lastAppliedSrcIdx.value > -1
                                        ? objBGLayerUi.name
                                        : "No Source"
                                    : ""



    color: objBGBaseRoot.iShowMatte === true
            ? Constants.objColorProperties.str121212Color
            : objColorUi
                ? objColorUi.color === Constants.objColorProperties.m_blackColor
                    ? Constants.objColorProperties.m_474747Color
                    : objColorUi.color
                : Constants.objColorProperties.str121212Color

    border.color:   if(modDestUi && objBGLayerUi) {
                        if(objBGLayerUi.bIsHovered)
                            Constants.objColorProperties.strFF7020Color
                        else if(bPreview && modDestUi.bIsPvwDestSelectedForBG)
                            Constants.objColorProperties.m_0B6DFFColor
                        else if(bProgram && modDestUi.bIsPgmDestSelectedForBG)
                            Constants.objColorProperties.m_0B6DFFColor
                        else
                            Constants.objColorProperties.m_474747Color
                    }
                    else
                        Constants.objColorProperties.m_474747Color

    border.width: 2

    Rectangle {
        id: objBGRectArea
        objectName: "objBGRectArea"
        width: parent.width - 4
        height: parent.height - 4
        anchors.centerIn: parent
        color: !objBGBaseRoot.iShowMatte ? objBGBaseRoot.color : Constants.objColorProperties.m_474747Color

        CustomImage {
            id: objBGImage
            objectName: "objBGImage"
            anchors.fill: parent
            source: if(objSourceUi ) {
                        if(objSourceUi.srcType.value === ProgrammingEnums.SrcTypeInput)
                            objSourceUi.inputCfgObject && objSourceUi.inputCfgObject.thumbnailUi.imagePath !== ""
                                    ? objSourceUi.inputCfgObject.thumbnailUi.imagePath
                                    : objSourceUi.inputCfgObject.imagePath
                        else if(objSourceUi.srcType.value === ProgrammingEnums.SrcTypeStill)
                            objSourceUi.containingStillStoreUi && objSourceUi.containingStillStoreUi.thumbnailUi.imagePath !== ""
                                    ? objSourceUi.containingStillStoreUi.thumbnailUi.imagePath
                                    : objSourceUi.containingStillStoreUi.imagePath
                        else if(objSourceUi.srcType.value === ProgrammingEnums.SrcTypeScreenDestPGM ||
                                objSourceUi.srcType.value === ProgrammingEnums.SrcTypeScreenDestPVW)
                            objSourceUi.containingScreenDestUi && objSourceUi.containingScreenDestUi.thumbnailUi.imagePath !== ""
                                    ? objSourceUi.containingScreenDestUi.thumbnailUi.imagePath
                                    : objSourceUi.containingScreenDestUi.imagePath
                        else if(objSourceUi.srcType.value === ProgrammingEnums.SrcTypeMvr)
                            objSourceUi.containingMultiViewerUi && objSourceUi.containingMultiViewerUi.thumbnailUi.imagePath !== ""
                                    ? objSourceUi.containingMultiViewerUi.thumbnailUi.imagePath
                                    : objSourceUi.containingMultiViewerUi.imagePath
                        else
                            ""
                    }
                    else
                        ""
            visible: objBGBaseRoot.iShowMatte
            property bool bCenteredImage : objBGLayerUi
                                            ? (false === objBGLayerUi.showMatte.value && objSourceUi)
                                                ? objBGLayerUi.bCenteredImage
                                                : false
                                            : false

            fillMode: bCenteredImage ? Image.PreserveAspectCrop : Image.Stretch
        }

        property int iHeaderFooterHieght: objBGRectArea.height < fullHDScale(120)
                                            ? fullHDScale(15)
                                            : (objBGRectArea.height / 5) > fullHDScale(30)
                                                ? fullHDScale(30)
                                                : objBGRectArea.height / 5

        Column { // to provide blend effect
            Row {
                Rectangle {
                    id: objBGBlendedHeader
                    objectName: "objBGBlendedHeader"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width
                    color: Constants.objColorProperties.strLayerTabBottomColor
                    opacity: 0.5
                }
            }

            Item {
                id: abcdefg
                objectName: "objSperator"
                height: objBGRectArea.height - (objBGBlendedHeader.height + objBGBlendedFooter.height)
                width: objBGRectArea.width
            }

            Row {
                visible: objBGRectArea.height > (1.5 * objBGRectArea.iHeaderFooterHieght)
                Rectangle {
                    id: objBGBlendedFooter
                    objectName: "objBGBlendedFooter"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width
                    color: Constants.objColorProperties.strLayerTabBottomColor
                    opacity: 0.5
                }
            }
        }

        Column {
            Row {
                Item {
                    id: backGroundHeaderRect
                    objectName: "backGroundHeaderRect"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width - fullHDScale(56)
                    visible: objBGRectArea.width > fullHDScale(46)

                    CustomText {
                        id: objDroppedBGName
                        objectName: "objDroppedBGName"
                        anchors.fill: parent
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: parent.left
                        anchors.leftMargin: fullHDScale(10)
                        text: objBGBaseRoot.iShowMatte ? objBGBaseRoot.szSourceName : "Matte"
                        elide: Text.ElideRight
                        clip: true
                    }
                }

                CustomSeparator {
                    height: objBGRectArea.iHeaderFooterHieght * 0.8
                    width:  fullHDScale(1)
                    color: Constants.objColorProperties.strD9D9D9Color
                    anchors.verticalCenter: parent.verticalCenter
                    visible: objBGRectArea.width > fullHDScale(46) ? objBGBaseRoot.iShowMatte : false
                }

                CustomSeparator {
                    height: objBGRectArea.iHeaderFooterHieght
                    width: fullHDScale(5)
                    color: Constants.objColorProperties.m_transparentColor
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item {
                    id: objDisplayBGRect
                    objectName: "objDisplayBGRect"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: fullHDScale(40)

                    CustomText {
                        id: objDisplayBGTypeText
                        objectName: "objDisplayBGTypeText"
                        anchors.fill: parent
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        text: bProgram ?  "BG A" : "BG B"
                        elide: Text.ElideRight
                    }
                }
            }

            Item {
                id: objSaperator1
                objectName: "objSaperator1"
                height: objBGRectArea.height - (2 * objBGRectArea.iHeaderFooterHieght)
                width: objBGRectArea.width
            }

            Row {
                spacing: fullHDScale(2)
                visible: objBGRectArea.height > (1.5 * objBGRectArea.iHeaderFooterHieght)
                Item {
                    id: objDispMRect
                    objectName: "objDispMRect"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width > fullHDScale(64) ? fullHDScale(18) : fullHDScale(0)
                    visible: objBGRectArea.width > fullHDScale(64)

                    CustomText {
                        id: objDispMText
                        objectName: "objDispMText"
                        anchors.fill: parent
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "M"
                        elide: Text.ElideRight
                    }
                }

                CustomSeparator {
                    height: objBGRectArea.iHeaderFooterHieght * 0.8
                    width: objBGRectArea.width > fullHDScale(64) ? objDispTText.visible ? fullHDScale(1) : fullHDScale(0) : fullHDScale(0)
                    color: Constants.objColorProperties.strD9D9D9Color
                    anchors.verticalCenter: parent.verticalCenter
                    visible: objBGRectArea.width > fullHDScale(64)
                }

                Item {
                    id: objDispTRect
                    objectName: "objDispTRect"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width > fullHDScale(64)
                            ? objToggleMode
                                ? objToggleMode.value
                                    ? fullHDScale(18)
                                    : fullHDScale(0)
                                : fullHDScale(0)
                            : fullHDScale(0)
                    visible: objBGRectArea.width > fullHDScale(64)

                    CustomText {
                        id: objDispTText
                        objectName: "objDispTText"
                        anchors.fill: parent
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "T"
                        elide: Text.ElideRight
                        visible: objToggleMode ? objToggleMode.value : false
                    }
                }

                // Swap will be part of Release 2.

                // CustomSeparator {
                //     height: objBGRectArea.iHeaderFooterHieght * 0.8
                //     width: objBGRectArea.width > fullHDScale(64) ? objDispTText.visible ? fullHDScale(1) : fullHDScale(0) : fullHDScale(0)
                //     color: !objDispTText.visible
                //             ? Constants.objColorProperties.m_transparentColor
                //             : Constants.objColorProperties.strD9D9D9Color
                //     anchors.verticalCenter: parent.verticalCenter
                //     visible: objBGRectArea.width > fullHDScale(64)
                // }

                // Item {
                //     id: objDispSRect
                //     objectName: "objDispSRect"
                //     height: objBGRectArea.iHeaderFooterHieght
                //     width: objBGRectArea.width > fullHDScale(64) ? fullHDScale(18) : fullHDScale(0)
                //     visible: objBGRectArea.width > fullHDScale(64)

                //     CustomText {
                //         id: objDispSText
                //         objectName: "objDispSText"
                //         anchors.fill: parent
                //         font.bold: true
                //         verticalAlignment: Text.AlignVCenter
                //         horizontalAlignment: Text.AlignHCenter
                //         text: "S"
                //         elide: Text.ElideRight
                //     }
                // }

                CustomSeparator {
                    height: objBGRectArea.iHeaderFooterHieght
                    width: objBGRectArea.width > fullHDScale(64)
                            ? (objBGRectArea.width - (objLockIcon.width * (objHideIcon.visible ? 2 : 1))) - (objDispTText.visible ? fullHDScale(54) : fullHDScale(30))
                            : (objBGRectArea.width - (objLockIcon.width * (objHideIcon.visible ? 2 : 1))) / 2
                    color: Constants.objColorProperties.m_transparentColor
                }

                Item {
                    id: objHideIcon
                    objectName: "objHideIcon"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: height
                    visible: objBGBaseRoot.objBGLayerUi
                                ? objBGBaseRoot.objBGLayerUi.presetRecallMode.value
                                : false

                    CustomImage {
                        id: objHideImage
                        objectName: "objHideImage"
                        width: fullHDScale(14)
                        height: fullHDScale(14)
                        source: GlobalConstants.objGlobalProperties.hidePasswordImage
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                // Item {
                //     id: objFreezeIcon
                //     objectName: "objFreezeIcon"
                //     height: objBGRectArea.iHeaderFooterHieght
                //     width: height
                //     visible: objBGBaseRoot.iShowMatte

                //     CustomImage {
                //         id: objFreezeImage
                //         objectName: "objFreezeImage"
                //         width: fullHDScale(14)
                //         height: fullHDScale(14)
                //         source: GlobalConstants.objGlobalProperties.urlFreeze
                //         anchors.verticalCenter: parent.verticalCenter
                //     }
                // }

                Item {
                    id: objLockIcon
                    objectName: "objLockIcon"
                    height: objBGRectArea.iHeaderFooterHieght
                    width: height

                    property bool bLocked: objBGBaseRoot.objBGLayerUi && objBGBaseRoot.objBGLayerUi.lockMode ? objBGBaseRoot.objBGLayerUi.lockMode.value : false
                    CustomImage {
                        id: objLockImage
                        objectName: "objLockImage"
                        width: fullHDScale(14)
                        height: fullHDScale(14)
                        source: objLockIcon.bLocked ? GlobalConstants.objGlobalProperties.urlLockIcon : GlobalConstants.objGlobalProperties.urlUnLockIcon
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        CustomLoader{
            id: objLinkMissingLoader
            anchors.centerIn: parent
            width: parent.width * 0.5
            sourceComponent: objLinkMissingComp
            height: parent.height * 0.15 > fullHDScale(40) ? fullHDScale(40) : parent.height * 0.15

            active: objBGLayerUi && !objBGLayerUi.showMatte.value ?  objBGLayerUi.bSourceLinkMissing : false

            Component {
                id: objLinkMissingComp
                LinkMissingItem {
                    id: objLinkMissingItem
                    anchors.fill: parent
                }
            }
        }

        BGDropComponent {
            id: objBGDropComponent
            objectName: "objBGDropComponent"
            anchors.fill: parent
            keys: Constants.objStaticKey.strPrgPrvBackGroundKey
            bProgram: objBGRoot.bProgram
            bProgRectIsLocked: objBGRoot.bProgRectIsLocked
            bIsBgLocked: objBGRoot.objBGLayerUi && objBGRoot.objBGLayerUi.lockMode ? objBGRoot.objBGLayerUi.lockMode.value : false
            objBGLayerUi : objBGRoot.objBGLayerUi
            enabled: iShowMatte
            onOnBGDropped: {
                if(objBGRoot.objBGLayerUi) {
                    if(!objBGRoot.objBGLayerUi.lockMode.value) {
                        objBGRoot.objBGLayerUi.qmlBGDropped(iXmlId)
                        objSysCollUi.m_objDestMgrUi.qmlUnselectAllBG()
                        objSysCollUi.m_objDestMgrUi.qmlUnselectAllLayers() // deselect all layers.
                        objSysCollUi.m_objDestMgrUi.qmlSetBIsBGLayerDropped(true)
                        if(bPreview)
                            modDestUi.qmlSetBIsPvwDestSelectedForBG(!modDestUi.bIsPvwDestSelectedForBG)
                        else
                            modDestUi.qmlSetBIsPgmDestSelectedForBG(!modDestUi.bIsPgmDestSelectedForBG)
                    }
                    else
                        objRootWindow.m_objCurrentSystem.setStatusBarText(ErrorEnums.BGLocked, ErrorEnums.Warning)
                }
            }
        }
    }
}