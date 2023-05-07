//
//  RootView.swift
//  
//
//  Created by p-x9 on 2023/04/20.
//  
//

import SwiftUI

struct RootView: View {
    @ObservedObject var preferences = Preferences(path: Constant.preferencePlistPath)

    @Environment(\.openURL) private var openURL

    var mainSection: some View {
        Section {
            VStack {
                HStack {
                    Text("Radius of touch point")
                    Spacer()
                    Text(String(format: "%.1f", preferences.radius.wrappedValue))
                }
                Divider()
                Slider(
                    value: preferences.radius,
                    in: 0...50,
                    label: {
                        Text("radius")
                    },
                    minimumValueLabel: {
                        Text("0")
                            .font(.caption)
                    },
                    maximumValueLabel: {
                        Text("50")
                            .font(.caption)
                    }
                )
            }
            ColorPicker("Color", selection: preferences.color.color)
        }
    }

    var offsetSection: some View {
        Section {
            HStack {
                Text("Offset")
                    .padding(.trailing)
                Divider()
                VStack {
                    HStack {
                        Text("x")
                        Spacer()
                        TextField("x", text: preferences.offset.x.string)
                            .multilineTextAlignment(.trailing)
                    }
                    Divider()
                    HStack {
                        Text("y")
                        TextField("y", text: preferences.offset.y.string)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        } header: {
            Text("Offset")
        }
        .textCase(nil)
        .keyboardType(.numbersAndPunctuation)
    }

    var borderSection: some View {
        Section {
            Toggle("Enabled", isOn: preferences.isBordered)
            VStack {
                HStack {
                    Text("Border Width")
                    Spacer()
                    Text(String(format: "%.1f", preferences.borderWidth.wrappedValue))
                }
                Divider()
                Slider(
                    value: preferences.borderWidth,
                    in: 0...10,
                    label: {
                        Text("border width")
                    },
                    minimumValueLabel: {
                        Text("0")
                            .font(.caption)
                    },
                    maximumValueLabel: {
                        Text("10")
                            .font(.caption)
                    }
                )
            }
            ColorPicker("Border Color", selection: preferences.borderColor.color)
        } header: {
            Text("Border")
        }
        .textCase(nil)
    }

    var shadowSection: some View {
        Section {
            Toggle("Enabled", isOn: preferences.isDropShadow)
            VStack {
                HStack {
                    Text("Shadow Radius")
                    Spacer()
                    Text(String(format: "%.1f", preferences.shadowRadius.wrappedValue))
                }
                Divider()
                Slider(
                    value: preferences.shadowRadius,
                    in: 0...10,
                    label: {
                        Text("shadow radius")
                    },
                    minimumValueLabel: {
                        Text("0")
                            .font(.caption)
                    },
                    maximumValueLabel: {
                        Text("10")
                            .font(.caption)
                    }
                )
            }
            ColorPicker("Color", selection: preferences.shadowColor.color)
            HStack {
                Text("Offset")
                    .padding(.trailing)
                Divider()
                VStack {
                    HStack {
                        Text("x")
                        Spacer()
                        TextField("x", text: preferences.shadowOffset.x.string)
                            .multilineTextAlignment(.trailing)
                    }
                    Divider()
                    HStack {
                        Text("y")
                        TextField("y", text: preferences.shadowOffset.y.string)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        } header: {
            Text("Shadow")
        }
        .textCase(nil)
    }

    var aboutSection: some View {
        Section {
            Button {
                openURL(URL(string: "https://github.com/p-x9/ShowTouch")!)
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "GitHub", in: .preference, with: nil) ?? UIImage())
                    Text("Source Code")
                }
            }

            Button {
                openURL(URL(string: "https://twitter.com/p_x9")!)
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "Twitter", in: .preference, with: nil) ?? UIImage())
                    Text("Twitter")
                }
            }

        } header: {
            Text("About")
        }
        .textCase(nil)
    }

    var body: some View {
        Form {
            Section {
                Toggle("Enabled", isOn: preferences.isEnabled)
            }

            mainSection

            offsetSection

            borderSection

            shadowSection

            aboutSection
        }
        .navigationBarTitle("ShowTouch")
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
