import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "companyName", "companyDescription", "userType" ]

    connect() {
        this.showCompanyDetails()
    }

    showCompanyDetails(event) {
        if (this.userTypeTarget.value === "employer") {
            this.companyNameTarget.removeAttribute("hidden")
            this.companyDescriptionTarget.removeAttribute("hidden")
        } else {
            this.companyNameTarget.setAttribute("hidden", true)
            this.companyDescriptionTarget.setAttribute("hidden", true)
        }
    }
}
