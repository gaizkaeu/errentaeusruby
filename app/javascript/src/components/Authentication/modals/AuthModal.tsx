import { Button, Modal, Text } from '@nextui-org/react'
import { useState } from 'react';
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom'
import AuthComponent from '../AuthComponent'

const AuthModal = (props: {method: boolean}) => {
  const nav = useNavigate();
  const loc = useLocation();
  const [open, setOpen] = useState(true);

  const onClose = () => {
    setOpen(false)
    setTimeout(() => {
          nav(loc.state?.background?.pathname ?? "/") 
    }, 50)
  }

  const onAuth = () => {
      setOpen(false)
      setTimeout(() => {
        nav(loc.state.nextPage, {replace: true})
    }, 50)
  }

  return (
    <div>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        animated={false}
        onClose={onClose}
        preventClose
        open={open}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            <Text b size={18}>
              Con tu cuenta proteges tu información. 
            </Text>
          </Text>
        </Modal.Header>
        <Modal.Body>
          <AuthComponent method={props.method} onAuth={onAuth}/>
        </Modal.Body>
        <Modal.Footer>
          <Text weight="light">Todos los datos están encriptados.</Text>
        </Modal.Footer>
      </Modal>
    </div>
  )
}
export default AuthModal
