import React from 'react'
import './CheckAnimated.css'

const CheckAnimated = () => {
  return (
    <svg
      className="checkmark addClass"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 52 52"
    >
      <circle
        className="checkmark__circle addClass"
        cx="26"
        cy="26"
        r="25"
        fill="none"
      />
      <path
        className="checkmark__check addClass"
        fill="none"
        d="M14.1 27.2l7.1 7.2 16.7-16.8"
      />
    </svg>
  )
}

export default CheckAnimated
