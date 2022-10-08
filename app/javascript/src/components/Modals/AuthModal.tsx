import { Button, Modal, Text, useModal } from '@nextui-org/react'
import { replace } from 'formik';
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom'
import AuthComponent from '../Authentication/AuthComponent'

const AuthModal = (props: {method: boolean}) => {
  const nav = useNavigate();
  const loc = useLocation();
  const {setVisible, bindings} = useModal(true)

  bindings.onClose = () => {
      setVisible(false)
      nav(-1)
  }

  const onAuth = () => {
      setVisible(false)
      nav(loc.state.nextPage, {replace: true})
  }

  return (
    <div>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        animated={false}
        preventClose
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
