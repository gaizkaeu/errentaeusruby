import { Text } from "@nextui-org/react"
import { useLocation, useNavigate, useParams } from "react-router-dom";
import { Modal } from "@nextui-org/react";
import { DocumentHistory } from "../Document";
import { useState } from "react";


const ShowDocumentHistory = () => {
    const [open, setOpen] = useState(true)
    const { document_id } = useParams()
    const loc = useLocation();
    const nav = useNavigate()

    const onClose = () => {
        setOpen(false)
        setTimeout(() => {
            nav(loc.state.background.pathname)
        }, 200)
    }
    return (
        <Modal
            closeButton
            aria-labelledby="modal-title"
            open={open}
            width="1200px"
            onClose={onClose}
        >
            <Modal.Header>
                <Text id="modal-title" size={18} b>
                    Historial
                </Text>
            </Modal.Header>
            <Modal.Body>
                <DocumentHistory documentId={document_id!}/>
            </Modal.Body>
        </Modal>
    )
}


export default ShowDocumentHistory;