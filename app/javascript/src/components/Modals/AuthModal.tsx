import { Button, Modal, Text } from '@nextui-org/react'
import { replace } from 'formik';
import { useLocation, useNavigate, useParams } from 'react-router-dom'
import AuthComponent from '../Authentication/AuthComponent'

const AuthModal = (props: {method: boolean}) => {
  const nav = useNavigate();
  const loc = useLocation();

  const closeHandler = () => {
      nav(-1)
  }

  const onAuth = () => {
      nav(loc.state.nextPage, {replace: true})
  }

  return (
    <div>
    <Modal
      closeButton
      aria-labelledby="modal-title"
      preventClose
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
