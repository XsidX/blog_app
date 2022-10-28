import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {
    // create multiple repeating targets with same name
    static targets = ["openCommentInput", "leaveCommentInput"]
    connect() {
        console.log("connected")
        this.openCommentInputTargets.forEach((target) => {
            target.addEventListener("click", (event) => {
                event.preventDefault()
                this.openCommentInput(event)
            })
        })

        this.leaveCommentInputTargets.forEach((target) => {
            target.addEventListener("click", (event) => {
                event.preventDefault()
                this.leaveCommentInput(event)
            })
        })
    }



    openCommentInput(event) {
        const ind = event.target.dataset.index
        const commentInput = document.getElementById(`comment-input-${ind}`)
        enter(commentInput)
    }

    leaveCommentInput(event) {
        const ind = event.target.dataset.index
        const commentInput = document.getElementById(`comment-input-${ind}`)
        leave(commentInput)
    }
}
