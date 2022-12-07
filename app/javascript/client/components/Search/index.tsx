import { MagnifyingGlassCircleIcon } from "@heroicons/react/24/outline";
import { Modal, Dropdown, Text } from "@nextui-org/react";
import { t } from "i18next";
import { ReactSearchAutocomplete } from "react-search-autocomplete";
import { useLazySearchUserQuery } from "../../storage/api";
import { TaxIncomeSearchKeys } from "../../storage/models/TaxIncome";
import { IUser } from "../../storage/types";
import { Button } from "../../utils/GlobalStyles";
import { UserAvatar } from "../Lawyer/Lawyer";

export const SearchBar = () => {
  const [visible, setVisible] = React.useState(false);
  const [selected, setSelected] = React.useState(TaxIncomeSearchKeys[0]);
  const [trigger] = useLazySearchUserQuery();

  const search_data: IUser[] = [];
  const [items, setItems] = React.useState(search_data);

  const handleOnSearch = async (string) => {
    console.log("the search is debounced!");
    trigger({ first_name: string })
      .unwrap()
      .then((data) => {
        setItems(data);
      });
  };

  const onSelect = (item) => {
    console.log(item);
  };

  const handler = () => setVisible(true);
  const closeHandler = () => {
    setVisible(false);
  };

  const formatResult = (item) => {
    return <UserAvatar user={item} size="md" />;
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
        <div className="w-full z-20">
          <ReactSearchAutocomplete
            items={items}
            aria-label="search client"
            onSearch={handleOnSearch}
            resultStringKeyName="first_name"
            onSelect={onSelect}
            inputDebounce={600}
            showIcon={false}
            fuseOptions={{ keys: ["first_name"] }}
            formatResult={formatResult}
          />
        </div>
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
