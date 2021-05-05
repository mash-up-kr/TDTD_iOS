//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: RollingpaperViewModel
    @State private var isPresentWriteView: Bool = false
    @State private var isPresentHostOptionView: Bool = false
    @State private var isRequestErrorAlert: Bool = false
    @State private var isPresentExitRoomAlert: Bool = false
    @State private var isRemoveRollingpaper: Bool = false
    @State private var isReportRollingpaper: Bool = false
    @State private var isPresentPlayer: Bool = false
    @State private var isPresentCopyConfirmAlert: Bool = false
    @Binding var isDeepLinkRefresh: Bool
    
    var randomRotate: Double {
        Double(Int.random(in: -10...10))
    }
    func randomImage(isSelect: Bool) -> Image {
        if isSelect {
            return CharacterAsset.select(color: CharacterAsset.randomColor).image
        } else {
            return CharacterAsset.normal(color: CharacterAsset.randomColor).image
        }
    }
    func imageColor(color: CharacterAsset.Color, isSelect: Bool) -> Image {
        if isSelect {
            return CharacterAsset.select(color: color).image
        } else {
            return CharacterAsset.normal(color: color).image
        }
    }
    
    var isNaviBarHidden: Bool {
        isReportRollingpaper || isRemoveRollingpaper || isPresentExitRoomAlert || isPresentCopyConfirmAlert
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Color("beige_1").ignoresSafeArea()
                playerView().ignoresSafeArea()
                hostOptionBottomSheetView().ignoresSafeArea()
                stickerGridView()
                bottomTrailingOptionButtonView()
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                NavigationItemView(name: "ic_arrow_left_24")
            }),
            trailing: Button(action: {
                if viewModel.isHost {
                    withAnimation(.spring()) {
                        isPresentHostOptionView = true
                        isPresentPlayer = false
                    }
                } else {
                    isPresentExitRoomAlert = true
                }
            }, label: {
                if viewModel.isHost {
                    NavigationItemView(name: "ic_more_24")
                } else {
                    NavigationItemView(name: "ic_leave_24")
                }
            }))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.roomTitleText)
            .sheet(isPresented: $isPresentWriteView) {
                RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(roomCode: viewModel.roomCode,
                                                                            roomType: viewModel.roomType),
                                      isPresentWriteView: $isPresentWriteView)
                    .environmentObject(viewModel)
            }
            .navigationBarHidden(isNaviBarHidden)
            .onAppear {
                viewModel.requestRoomDetailInfo()
            }
            .onReceive(viewModel.$isRoomRemoved) { isRemove in
                if isRemove {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .onReceive(viewModel.$isRequestErrorAlert) { isAlert in
                if let isAlert = isAlert, isAlert {
                    isRequestErrorAlert = true
                }
            }
            .onReceive(viewModel.$isCommentRemoved) { isRemoved in
                if isRemoved {
                    withAnimation {
                        isPresentPlayer = false
                    }
                }
            }
            .alert(isPresented: $isRequestErrorAlert) {
                Alert(title: Text("통신 오류"), message: Text("알 수 없는 오류가\n발생했어요!"))
            }
            playerOptionAlertView().ignoresSafeArea()
            exitRoomAlertView().ignoresSafeArea()
            copyConfirmAlertView().ignoresSafeArea()
        }
        .environmentObject(viewModel)
        .onChange(of: isPresentPlayer) {
            if !$0 {
                viewModel.playerReset()
            }
        }
        .onChange(of: isDeepLinkRefresh) {
            if $0 {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onDisappear() {
            isDeepLinkRefresh = false
        }
    }
    
    @ViewBuilder
    private func stickerGridView() -> some View {
        if viewModel.models.isEmpty {
            emptyView()
                .offset(x: 0, y: -30)
        } else {
            ScrollView {
                let columns = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.models.indices, id: \.self) { index in
                        let isSelect = isPresentPlayer ? viewModel.selectIndex == index : false
                        imageColor(color: viewModel.models[index].stickerColor, isSelect: isSelect)
                            .onTapGesture {
                                if !isPresentPlayer {
                                    viewModel.selectIndex = index
                                }
                                withAnimation {
                                    isPresentPlayer.toggle()
                                    if isPresentPlayer {
                                        isPresentHostOptionView = false
                                    }
                                }
                            }
                            .offset(x: viewModel.models[index].horizontalSpacing,
                                    y: viewModel.models[index].verticalSpacing)
                            .rotationEffect(Angle(degrees: Double(viewModel.models[index].stickerAngle)))
                            .frame(height: 146)
                    }
                }
                .padding(16)
            }
        }
    }
    
    @ViewBuilder
    private func emptyView() -> some View {
        if viewModel.isHost {
            if viewModel.isMakeRoom {
                VStack(spacing: 24) {
                    PlaceholderView(text: "오른쪽 상단 더보기 버튼을 눌러서\n초대링크를 보낼수있어요!")
                        .multilineTextAlignment(.center)
                    Button(action: {
                        copyRoomCodeLink()
                    }, label: {
                        Text("초대링크 보내기")
                    })
                    .buttonStyle(RoundButtonStyle(style: .dark))
                    .frame(width: 148)
                }
            } else {
                PlaceholderView(text: "아직 아무도 답장을 하지 않았어요\n다른 사람에게도 초대링크를 보내보세요!")
                    .multilineTextAlignment(.center)
            }
        } else {
            PlaceholderView(text: "친구에게 마음을 속삭여보세요!")
        }
    }
    
    @ViewBuilder
    private func playerView() -> some View {
        if isPresentPlayer && viewModel.selectIndex != nil {
            VStack {
                Spacer()
                PlayerView(isRemoveRollingpaper: $isRemoveRollingpaper,
                           isReportRollingpaper: $isReportRollingpaper,
                           isPresentPlayer: $isPresentPlayer)
            }
            .transition(.move(edge: .bottom))
            .zIndex(1)
        }
    }
    
    @ViewBuilder
    private func playerOptionAlertView() -> some View {
        if isReportRollingpaper {
            AlertView(title: "답장 신고하기",
                      msg: "답장을 신고하시겠어요?🚨",
                      leftTitle: "신고할래요",
                      leftAction: {
                        viewModel.requestReport()
                        isReportRollingpaper = false
                      },
                      rightTitle: "안할래요!",
                      rightAction: {
                        isReportRollingpaper = false
                      })
        }
        if isRemoveRollingpaper {
            AlertView(title: "답장 삭제하기",
                      msg: "정말 답장을 삭제하시겠어요?😭",
                      leftTitle: "삭제할래요",
                      leftAction: {
                        viewModel.requestRemoveComment()
                        isRemoveRollingpaper = false
                        viewModel.selectIndex = nil
                      },
                      rightTitle: "안할래요!",
                      rightAction: {
                        isRemoveRollingpaper = false
                      })
        }
    }
    
    @ViewBuilder
    private func exitRoomAlertView() -> some View {
        if isPresentExitRoomAlert {
            if viewModel.isHost {
                AlertView(title: "방 삭제하기",
                          msg: "정말 롤링페이퍼 방을 삭제하시겠어요?😭",
                          leftTitle: "방 삭제하기",
                          leftAction: {
                            viewModel.requestExitRoom()
                            isPresentExitRoomAlert = false
                          },
                          rightTitle: "안할래요!",
                          rightAction: {
                            isPresentExitRoomAlert = false
                          }
                )
            } else {
                AlertView(title: "방 나가기",
                          msg: "정말 롤링페이퍼 방을 나가시겠어요?😭",
                          leftTitle: "방나가기",
                          leftAction: {
                            viewModel.requestExitRoom()
                            isPresentExitRoomAlert = false
                          },
                          rightTitle: "안나갈래요!",
                          rightAction: {
                            isPresentExitRoomAlert = false
                          }
                )
            }
        }
    }
    
    @ViewBuilder
    private func bottomTrailingOptionButtonView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        viewModel.requestBookmark(delete: viewModel.isBookmark)
                    }, label: {
                        viewModel.isBookmark ? Image("img_favorite_active") : Image("img_favorite_default")
                    })
                    .frame(width: 56, height: 56)
                    Spacer().frame(height: 24)
                    Button(action: {
                        isPresentWriteView = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(viewModel.isEnableWriteButton ?
                                    ColorPallete.grayscale(1).color : ColorPallete.grayscale(1).color.opacity(0.3))
                            .overlay(Image("ic_write_32"))
                    })
                    .allowsHitTesting(viewModel.isEnableWriteButton)
                    .frame(width: 56, height: 56)
                }
            }
            .padding(.trailing, 16)
        }
        .padding(.bottom, 24)
    }
    
    @ViewBuilder
    private func hostOptionBottomSheetView() -> some View {
        if isPresentHostOptionView {
            VStack {
                Spacer()
                ZStack {
                    ColorPallete.beige(3).color
                    VStack {
                        HStack(spacing: 0) {
                            UhBeeZigleText("이 롤링페이퍼 방은",
                                           size: 16,
                                           weight: .bold,
                                           pallete: .grayscale(3))
                            UhBeeZigleText(viewModel.roomCreatedAt?.convertKORDate ?? "조금 전",
                                           size: 16,
                                           weight: .bold,
                                           pallete: .grayscale(2))
                            UhBeeZigleText("에 만들어졌어요!",
                                           size: 16,
                                           weight: .bold,
                                           pallete: .grayscale(3))
                        }
                        Spacer().frame(height: 16)
                        VStack(alignment: .leading) {
                            Button(action: {
                                copyRoomCodeLink()
                            }, label: {
                                HStack(spacing: 8) {
                                    Image("ic_share_32")
                                    UhBeeZigleText("작성자 초대 링크 공유하기",
                                                   size: 20,
                                                   weight: .bold,
                                                   pallete: .grayscale(1))
                                        .layoutPriority(1)
                                    Spacer()
                                }
                            })
                            .frame(height: 48)
                            Spacer().frame(height: 8)
                            Button(action: {
                                isPresentExitRoomAlert = true
                            }, label: {
                                HStack(spacing: 8) {
                                    Image("ic_trash_32")
                                    UhBeeZigleText("방 삭제하기",
                                                   size: 20,
                                                   weight: .bold,
                                                   pallete: .grayscale(1))
                                        .layoutPriority(1)
                                    Spacer()
                                }
                            })
                            .frame(height: 48)
                            Spacer().frame(height: 16)
                            Button(action: {
                                withAnimation(.spring()) {
                                    isPresentHostOptionView = false
                                }
                            }, label: {
                                Text("아무것도 안할래요")
                            })
                            .buttonStyle(RoundButtonStyle(style: .dark))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 38)
                }
                .frame(height: 254)
                .cornerRadius(radius: 24, cornerStyle: [.topLeft, .topRight])
            }
            .transition(.move(edge: .bottom))
            .zIndex(1)
        }
    }
    
    @ViewBuilder
    private func copyConfirmAlertView() -> some View {
        if isPresentCopyConfirmAlert {
            AlertView(title: "초대코드 복사완료!",
                      msg: "초대코드를 친구들에게 전달해주세요!🥰",
                      rightTitle: "확인",
                      rightAction: {
                        isPresentCopyConfirmAlert = false
                      })
        }
    }
    
    private func copyRoomCodeLink() {
        let shareLink = viewModel.shareURL
        UIPasteboard.general.string = shareLink
        isPresentCopyConfirmAlert = true
    }
}

struct RollingpaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperView(viewModel: RollingpaperViewModel(roomInfo: RoomSummary(isHost: true,
                                                                                title: "타이틀",
                                                                                roomCode: "1ab3",
                                                                                isBookmark: true,
                                                                                createdAt: "2021-04-12T16:59:35",
                                                                                shareURL: nil)), isDeepLinkRefresh: Binding<Bool>.constant(false))
    }
}

enum CharacterAsset {
    case normal(color: CharacterAsset.Color)
    case select(color: CharacterAsset.Color)
    
    enum Color: String, CaseIterable {
        case red = "RED"
        case yellow = "YELLOW"
        case green = "GREEN"
        case blue = "BLUE"
        case lavender = "LAVENDER"
        case lightPink = "LIGHT_PINK"
        case lightGreen = "LIGHT_GREEN"
    }
    
    var image: Image {
        switch self {
        case .normal(let color):
            let assetString = imageString(color)
             return Image("\(assetString)default")
        case .select(let color):
            let assetString = imageString(color)
            return  Image("\(assetString)select")
        }
    }
    
    private func imageString(_ color: CharacterAsset.Color) -> String {
        switch color {
        case .red:
            return "img_character_1_center_"
        case .yellow:
            return "img_character_2_center_"
        case .green:
            return "img_character_3_center_"
        case .blue:
            return "img_character_4_center_"
        case .lavender:
            return "img_character_5_center_"
        case .lightPink:
            return "img_character_6_center_"
        case .lightGreen:
            return "img_character_7_center_"
        }
    }
    
    static var randomColor: CharacterAsset.Color {
        CharacterAsset.Color.allCases.randomElement() ?? .lightPink
    }
}
