import { Modal, Text } from "@nextui-org/react";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import AuthComponent from "../AuthComponent";
import { useAuth } from "../../../hooks/authHook";

const AuthModal = (props: { method: boolean }) => {
  const nav = useNavigate();
  const loc = useLocation();
  const [open, setOpen] = useState(true);
  const { status, components } = useAuth();

  useEffect(() => {
    if (status.fetched && status.loggedIn) {
      setOpen(false);
    }
  }, [status]);

  const onClose = () => {
    setTimeout(() => {
      if (status.loggedIn) {
        nav(loc.state.nextPage, { replace: true });
      } else {
        nav(loc.state?.background?.pathname ?? "/");
      }
    }, 50);
  };

  return (
    <div>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        preventClose
        open={open}
        onClose={onClose}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            <Text b size={18}>
              Con tu cuenta proteges tu información.
            </Text>
          </Text>
        </Modal.Header>
        <Modal.Body>
          <AuthComponent method={props.method} />
        </Modal.Body>
        <Modal.Footer>{components.google()}</Modal.Footer>
      </Modal>
    </div>
  );
};
export default AuthModal;
