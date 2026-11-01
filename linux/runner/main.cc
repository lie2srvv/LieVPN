#include "my_application.h"

#include <glib.h>
#include <unistd.h>

int main(int argc, char** argv) {
  // Ensure DBUS_SESSION_BUS_ADDRESS is set for AppImage and Wayland environments
  const gchar* dbus_bus = g_getenv("DBUS_SESSION_BUS_ADDRESS");
  if (dbus_bus == nullptr || strlen(dbus_bus) == 0) {
    uid_t uid = getuid();
    g_autofree gchar* default_bus_path = g_strdup_printf("/run/user/%d/bus", uid);
    if (g_file_test(default_bus_path, G_FILE_TEST_EXISTS)) {
      g_autofree gchar* default_bus = g_strdup_printf("unix:path=%s", default_bus_path);
      g_setenv("DBUS_SESSION_BUS_ADDRESS", default_bus, TRUE);
    }
  }

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
