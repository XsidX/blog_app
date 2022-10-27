import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {
  static targets = [ "openMyMenu", "openUserDropdown", "openPostDropdown" ]
  connect() {
    this.openMyMenuTarget.addEventListener('click', this.toggleMyDropdownMenu)
    this.openUserDropdownTarget.addEventListener('click', this.toggleUserDropdownMenu)
    this.openPostDropdownTarget.addEventListener('click', this.togglePostDropdownMenu)
  }

  toggleMyDropdownMenu() {
    toggle(document.getElementById('my-dropdown-menu'))
  }

  toggleUserDropdownMenu() {
    toggle(document.getElementById('user-dropdown-menu'))
  }

  togglePostDropdownMenu() {
    toggle(document.getElementById('post-dropdown-menu'))
  }

}
