//
//  MeditationsView.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/7/21.
//

import SwiftUI

struct MeditationsView: View {
	@ObservedObject var meditationsViewModel = MeditationsViewModel()

	var currentMeditations: [String]

    var body: some View {
		ScrollView {
			VStack {
				HStack {
					Text("Great for Beginners")
						.font(.largeTitle)
						.fontWeight(.heavy)
						.multilineTextAlignment(.leading)
					Spacer()
				}
				.padding(.all)
				Text("A biologist predicts a population bomb that will lead to a global catastrophe. An economist sees a limitless future for mankind. The result is one of the most famous bets in economics.")
					.padding()

				ForEach(meditationsViewModel.meditationItemViewModels ?? [MeditationItemViewModel]()) { meditationItem in
					if
						let theMeditationItemID = meditationItem.id,
						currentMeditations.contains(theMeditationItemID),
						let theTitle = meditationItem.title,
						let theInstructor = meditationItem.teacherName,
						let theImageURL = meditationItem.imageURL {

						MeditationItemView(imageURL: theImageURL,
										   lessonTitle: theTitle,
										   instructor: theInstructor)
					}

				}

				
			}
		}

    }
}

struct MeditationsView_Previews: PreviewProvider {

	static let theMeditations = ["8346cb88-b657-479f-9126-c2c02c180828", "8db15d31-819b-48e2-8a52-661d6356d2fe", "8ebe08ed-6a85-4553-98b1-456ef8326336", "8161d7ea-ffb1-476e-99d6-fefc89afcf80", "448f1f17-1158-4b1e-be45-414c1d5876ed", "35c0048c-8ca7-4185-bc02-8c7d1f00d765", "bbf70f4d-675a-4369-83c3-1bbc5c550101", "66f3e59e-0c88-4f35-9831-ada294d83be2", "ff7386a2-5bd3-45d2-accf-b08dcf470658", "71bf016c-47b0-4d01-a7fb-2933a20fa873", "26d7d194-8d16-4a6f-91e5-b1f07345abc8", "bf4246e0-89b5-47a2-a359-fbcae2103dbf", "10bda08a-b138-410f-8781-f0cbd4d715a0", "460c0495-7971-4c98-8ed8-bb03a6c23ed0", "80b25fa6-a0cd-4ab9-bedd-95a055eb0b2d", "ad817276-1215-4045-af28-4601b76ed5fe", "d31ca45f-a993-4ea5-aa2d-2e7a1e8abb62", "7763f503-b242-494d-8e68-f945f3c9b621", "3e3902a3-7c6d-4b34-ae20-74bfda408d9a", "54518fa3-b0a6-4ebb-98f4-bd6313735079", "cb852965-67e4-4b4c-a2d0-c3765c3224bc", "1cd473ac-d2e4-47cc-ab21-b2f41e08f775", "b0d5d25e-dd1c-48fc-a11a-71293bfe568e", "ee3a2759-0a39-4342-a176-138804217077", "52d11b72-1deb-413f-95af-1822923ba532", "ab114638-3fb1-4f24-bed8-01021d2a843b", "04a114c0-ada8-4d51-99bc-e8198d61a884", "a11b4ce7-3a44-4e4d-9819-d1645750f6a0"]

    static var previews: some View {
        MeditationsView(currentMeditations: theMeditations)
    }
}
