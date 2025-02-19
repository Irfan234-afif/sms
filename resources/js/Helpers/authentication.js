export default {
  install(app) {
    app.config.globalProperties.$authHasRoles = function (auth, collect) {
      const { roles } = auth;
      if (roles && collect) {
        return roles.some((r) => collect.indexOf(r) >= 0);
      }
      return false;
    };
    app.config.globalProperties.$authHasPermissions = function (auth, collect) {
      const { permissions } = auth;
      if (permissions && collect) {
        return permissions.some((r) => collect.indexOf(r) >= 0);
      }
      return false;
    };
  },
};
