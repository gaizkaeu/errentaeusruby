import React, { useState } from 'react'
import { Button, Modal, Text, useModal } from '@nextui-org/react'
import { useAuth } from '../../storage/hooks'
import SignIn from '../Authentication/SignIn'
import SignUp from '../Authentication/SignUp'
import { useNavigate, useParams } from 'react-router-dom'
import AuthComponent from '../Authentication/AuthComponent'

const AuthModal = () => {
  const nav = useNavigate();
  const { bindings } = useModal(true);

  const closeHandler = () => {
    nav(-1)
  };

  return (
    <div>
    <Modal
      closeButton
      aria-labelledby="modal-title"
      onCloseButtonClick={closeHandler}
      {...bindings}
    >
      <Modal.Header>
        <Text id="modal-title" size={18}>
          <Text b size={18}>
            Con tu cuenta proteges tu información. 
          </Text>
        </Text>
      </Modal.Header>
      <Modal.Body>
        <AuthComponent/>
      </Modal.Body>
      <Modal.Footer>
        <Button auto flat color="error" onClick={closeHandler}>
          Close
        </Button>
        <Button auto onClick={closeHandler}>
          Sign in
        </Button>
      </Modal.Footer>
    </Modal>
    </div>
  )
}
export default AuthModal
