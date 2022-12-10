import { MagnifyingGlassCircleIcon } from "@heroicons/react/24/outline";
import { Modal, Dropdown, Text } from "@nextui-org/react";
import { TaxIncomeSearchKeys } from "../../storage/models/TaxIncome";
import { Button } from "../../utils/GlobalStyles";

export const SearchBar = () => {
  const [visible, setVisible] = React.useState(false);
  const [selected, setSelected] = React.useState(TaxIncomeSearchKeys[0]);

  const handler = () => setVisible(true);
  const closeHandler = () => {
    setVisible(false);
  };

  return (
    <div className="flex gap-4 items-center">
      <div className="grow flex gap-2 items-center">
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
        <div className="w-full z-20"></div>
      </div>
      <Button
        auto
        aria-label="advanced search"
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
            Búsqueda avanzada
          </Text>
        </Modal.Header>
        <Modal.Body>
          <Text></Text>
        </Modal.Body>
        <Modal.Footer>
          <Button auto onClick={closeHandler}>
            Buscar
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};
