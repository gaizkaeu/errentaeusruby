import { MagnifyingGlassCircleIcon } from "@heroicons/react/24/outline";
import { Modal, Input, Dropdown, Text } from "@nextui-org/react";
import { t } from "i18next";
import { useState } from "react";
import { TaxIncomeSearchKeys } from "../../storage/models/TaxIncome";
import { Button } from "../../utils/GlobalStyles";

export const SearchBar = () => {
  const [visible, setVisible] = useState(false);
  const [selected, setSelected] = React.useState(TaxIncomeSearchKeys[0]);

  const handler = () => setVisible(true);
  const closeHandler = () => {
    setVisible(false);
  };

  return (
    <div className="flex gap-4">
      <div className="grow flex gap-2">
        <Dropdown>
          <Dropdown.Button flat color="secondary" css={{ tt: "capitalize" }}>
            {selected}
          </Dropdown.Button>
          <Dropdown.Menu
            aria-label="Single selection actions"
            color="secondary"
            disallowEmptySelection
            selectionMode="single"
            selectedKeys={selected}
            onSelectionChange={setSelected}
          >
            {TaxIncomeSearchKeys.map((val) => {
              return <Dropdown.Item key={val}>{val}</Dropdown.Item>;
            })}
          </Dropdown.Menu>
        </Dropdown>
        <Input fullWidth placeholder="Gaizka" type="search" />
      </div>
      <Button
        auto
        onPress={handler}
        icon={<MagnifyingGlassCircleIcon height="20px" />}
      >
        <span className="hidden md:inline">Avanzado</span>
      </Button>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        open={visible}
        onClose={closeHandler}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            {t("taxincome.actions.delete.modalTitle")}
          </Text>
        </Modal.Header>
        <Modal.Body>
          <Text>{t("taxincome.actions.delete.disclaimer")}</Text>
        </Modal.Body>
        <Modal.Footer>
          <Button auto flat color="error">
            {t("taxincome.actions.delete.confirmButton")}
          </Button>
          <Button auto onClick={closeHandler}>
            {t("taxincome.actions.delete.cancel")}
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};