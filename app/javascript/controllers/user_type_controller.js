import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "companyName", "companyDescription" ]

    showCompanyDetails(event) {
        if (event.target.value === "employer") {
            this.companyNameTarget.removeAttribute("hidden")
            this.companyDescriptionTarget.removeAttribute("hidden")
        } else {
            this.companyNameTarget.setAttribute("hidden", true)
            this.companyDescriptionTarget.setAttribute("hidden", true)
        }
    }
}
