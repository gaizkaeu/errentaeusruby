import { Card, Text, User } from "@nextui-org/react";
import { Fragment } from "react";
import { HeaderMin } from "../components/Header";

function ProfilePage() {
  return (
    <Fragment>
      <HeaderMin
        title="profile.title"
        gradient="45deg, $green400 -20%, $cyan600 50%"
      />
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div className="pt-4 lg:grid lg:grid-cols-10 lg:gap-x-5">
          <aside className="pb-4 px-2 sm:px-6 lg:py-0 lg:px-0 lg:col-span-2">
            <div>
              <nav className="space-y-3">
                <a
                  href="https://account.rwx.com/gaizkaurd/manage/overview"
                  className="bg-gray-50 text-blue-500 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon stroke-blue-500 flex-shrink-0 group-hover:stroke-blue-500 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M12 16V12M12 8H12.01M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3" color="primary">
                    Overview
                  </Text>
                </a>
                <a
                  href=""
                  className="text-slate-600 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon flex-shrink-0 group-hover:stroke-blue-500 stroke-slate-400 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M17 8.99994C17 8.48812 16.8047 7.9763 16.4142 7.58579C16.0237 7.19526 15.5118 7 15 7M15 15C18.3137 15 21 12.3137 21 9C21 5.68629 18.3137 3 15 3C11.6863 3 9 5.68629 9 9C9 9.27368 9.01832 9.54308 9.05381 9.80704C9.11218 10.2412 9.14136 10.4583 9.12172 10.5956C9.10125 10.7387 9.0752 10.8157 9.00469 10.9419C8.937 11.063 8.81771 11.1823 8.57913 11.4209L3.46863 16.5314C3.29568 16.7043 3.2092 16.7908 3.14736 16.8917C3.09253 16.9812 3.05213 17.0787 3.02763 17.1808C3 17.2959 3 17.4182 3 17.6627V19.4C3 19.9601 3 20.2401 3.10899 20.454C3.20487 20.6422 3.35785 20.7951 3.54601 20.891C3.75992 21 4.03995 21 4.6 21H7V19H9V17H11L12.5791 15.4209C12.8177 15.1823 12.937 15.063 13.0581 14.9953C13.1843 14.9248 13.2613 14.8987 13.4044 14.8783C13.5417 14.8586 13.7588 14.8878 14.193 14.9462C14.4569 14.9817 14.7263 15 15 15Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3">Contraseña</Text>
                </a>
                <a
                  href="https://account.rwx.com/gaizkaurd/manage/support"
                  className="text-slate-600 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon flex-shrink-0 group-hover:stroke-blue-500 stroke-slate-400 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M9.09 9C9.3251 8.33167 9.78915 7.76811 10.4 7.40913C11.0108 7.05016 11.7289 6.91894 12.4272 7.03871C13.1255 7.15849 13.7588 7.52152 14.2151 8.06353C14.6713 8.60553 14.9211 9.29152 14.92 10C14.92 12 11.92 13 11.92 13M12 17H12.01M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3">Ayuda</Text>
                </a>
              </nav>
            </div>
            <div className="mt-8">
              <div className="text-slate-600 text-sm font-medium ml-2 mb-1">
                Otros
              </div>
              <nav className="space-y-3">
                <a
                  href="https://account.rwx.com/gaizkaurd/manage/integrations"
                  className="text-slate-600 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon flex-shrink-0 group-hover:stroke-blue-500 stroke-slate-400 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M11 4.5H18.3C19.4201 4.5 19.9802 4.5 20.408 4.71799C20.7843 4.90973 21.0903 5.21569 21.282 5.59202C21.5 6.01984 21.5 6.57989 21.5 7.7V9C21.5 9.93188 21.5 10.3978 21.3478 10.7654C21.1448 11.2554 20.7554 11.6448 20.2654 11.8478C19.8978 12 19.4319 12 18.5 12M13 19.5H5.7C4.5799 19.5 4.01984 19.5 3.59202 19.282C3.21569 19.0903 2.90973 18.7843 2.71799 18.408C2.5 17.9802 2.5 17.4201 2.5 16.3V15C2.5 14.0681 2.5 13.6022 2.65224 13.2346C2.85523 12.7446 3.24458 12.3552 3.73463 12.1522C4.10218 12 4.56812 12 5.5 12M10.3 14.5H13.7C13.98 14.5 14.12 14.5 14.227 14.4455C14.3211 14.3976 14.3976 14.3211 14.4455 14.227C14.5 14.12 14.5 13.98 14.5 13.7V10.3C14.5 10.02 14.5 9.87996 14.4455 9.773C14.3976 9.67892 14.3211 9.60243 14.227 9.5545C14.12 9.5 13.98 9.5 13.7 9.5H10.3C10.02 9.5 9.87996 9.5 9.773 9.5545C9.67892 9.60243 9.60243 9.67892 9.5545 9.773C9.5 9.87996 9.5 10.02 9.5 10.3V13.7C9.5 13.98 9.5 14.12 9.5545 14.227C9.60243 14.3211 9.67892 14.3976 9.773 14.4455C9.87996 14.5 10.02 14.5 10.3 14.5ZM17.8 22H21.2C21.48 22 21.62 22 21.727 21.9455C21.8211 21.8976 21.8976 21.8211 21.9455 21.727C22 21.62 22 21.48 22 21.2V17.8C22 17.52 22 17.38 21.9455 17.273C21.8976 17.1789 21.8211 17.1024 21.727 17.0545C21.62 17 21.48 17 21.2 17H17.8C17.52 17 17.38 17 17.273 17.0545C17.1789 17.1024 17.1024 17.1789 17.0545 17.273C17 17.38 17 17.52 17 17.8V21.2C17 21.48 17 21.62 17.0545 21.727C17.1024 21.8211 17.1789 21.8976 17.273 21.9455C17.38 22 17.52 22 17.8 22ZM2.8 7H6.2C6.48003 7 6.62004 7 6.727 6.9455C6.82108 6.89757 6.89757 6.82108 6.9455 6.727C7 6.62004 7 6.48003 7 6.2V2.8C7 2.51997 7 2.37996 6.9455 2.273C6.89757 2.17892 6.82108 2.10243 6.727 2.0545C6.62004 2 6.48003 2 6.2 2H2.8C2.51997 2 2.37996 2 2.273 2.0545C2.17892 2.10243 2.10243 2.17892 2.0545 2.273C2 2.37996 2 2.51997 2 2.8V6.2C2 6.48003 2 6.62004 2.0545 6.727C2.10243 6.82108 2.17892 6.89757 2.273 6.9455C2.37996 7 2.51997 7 2.8 7Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3">Pagos</Text>
                </a>
                <a
                  href="https://account.rwx.com/gaizkaurd/manage/hidden_repositories"
                  className="text-slate-600 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon flex-shrink-0 group-hover:stroke-blue-500 stroke-slate-400 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M3 8L15 8M15 8C15 9.65686 16.3431 11 18 11C19.6569 11 21 9.65685 21 8C21 6.34315 19.6569 5 18 5C16.3431 5 15 6.34315 15 8ZM9 16L21 16M9 16C9 17.6569 7.65685 19 6 19C4.34315 19 3 17.6569 3 16C3 14.3431 4.34315 13 6 13C7.65685 13 9 14.3431 9 16Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3">Mi historial</Text>
                </a>
                <a
                  href="https://account.rwx.com/gaizkaurd/manage/notifications"
                  className="text-slate-600 group rounded-md p-2 flex items-center text-sm font-medium hover:text-blue-700"
                  aria-current="page"
                >
                  <svg
                    className="icon flex-shrink-0 group-hover:stroke-blue-500 stroke-slate-400 h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    stroke="currentColor"
                  >
                    <title></title>
                    <path
                      d="M9.35418 21C10.0593 21.6224 10.9856 22 12 22C13.0144 22 13.9407 21.6224 14.6458 21M18 8C18 6.4087 17.3679 4.88258 16.2426 3.75736C15.1174 2.63214 13.5913 2 12 2C10.4087 2 8.88258 2.63214 7.75736 3.75736C6.63214 4.88258 6 6.4087 6 8C6 11.0902 5.22047 13.206 4.34966 14.6054C3.61513 15.7859 3.24786 16.3761 3.26132 16.5408C3.27624 16.7231 3.31486 16.7926 3.46178 16.9016C3.59446 17 4.19259 17 5.38885 17H18.6111C19.8074 17 20.4055 17 20.5382 16.9016C20.6851 16.7926 20.7238 16.7231 20.7387 16.5408C20.7521 16.3761 20.3849 15.7859 19.6503 14.6054C18.7795 13.206 18 11.0902 18 8Z"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    ></path>
                  </svg>

                  <Text className="ml-3">Notificaciones</Text>
                </a>
              </nav>
            </div>
          </aside>
          <Card
            variant="flat"
            className="space-y-6 sm:px-6 lg:px-0 lg:col-span-8"
          >
            <Card.Body>
              <User
                text="Gaizka"
                name="Tu perfil"
                description="Gaizka Urdangarin"
                size="xl"
              />
            </Card.Body>
          </Card>
        </div>
      </main>
    </Fragment>
  );
}

export default ProfilePage;
