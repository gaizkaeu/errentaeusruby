import { Button, Modal, Text } from '@nextui-org/react'
import { useNavigate, useParams } from 'react-router-dom'
import AuthComponent from '../Authentication/AuthComponent'

const AuthModal = () => {
  const nav = useNavigate();

  const closeHandler = () => {
    nav(-1)
  };

  return (
    <div>
    <Modal
      closeButton
      aria-labelledby="modal-title"
      onClose={closeHandler}
      open={true}
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
        <Text weight="light">Todos los datos están encriptados.</Text>
      </Modal.Footer>
    </Modal>
    </div>
  )
}
export default AuthModal
