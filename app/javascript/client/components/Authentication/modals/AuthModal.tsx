import { Modal, Text } from "@nextui-org/react";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import AuthComponent from "../AuthComponent";
import { useAuth } from "../../../hooks/authHook";
import { GoogleOAuthProvider } from "@react-oauth/google";

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
        nav(loc.state.nextPage ?? "/mytaxincome", { replace: true });
      } else {
        nav(-1);
      }
    }, 50);
  };

  return (
    <div>
      <GoogleOAuthProvider clientId="321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com">
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
      </GoogleOAuthProvider>
    </div>
  );
};
export default AuthModal;
