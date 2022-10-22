import { Button, Modal, Text, useModal } from '@nextui-org/react'
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom'

const EstimationEditModal = () => {
  const nav = useNavigate();
  const loc = useLocation();
  const {setVisible, bindings} = useModal(true)

  bindings.onClose = () => {
      setVisible(false)
      nav(-1)
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
                Editar estimación
            </Text>
          </Text>
        </Modal.Header>
        <Modal.Body>
            <Text>Lo estoy editando</Text>
        </Modal.Body>
        <Modal.Footer>
          <Text weight="light">Todos los datos están encriptados.</Text>
        </Modal.Footer>
      </Modal>
    </div>
  )
}
export default EstimationEditModal
