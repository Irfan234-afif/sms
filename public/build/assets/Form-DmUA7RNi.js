import './_plugin-vue_export-helper-DlAUqK2U.js';
import {
  g as _,
  f as c,
  p as d,
  o as f,
  t as g,
  a as i,
  c as k,
  E as m,
  b as n,
  w as r,
  h as V,
  x as v,
} from './app-DRwuzDen.js';
import { D as p } from './DefaultButton-BI1xwmx8.js';
import { f as b } from './fieldValidation-NAdqwKjZ.js';
import { m as y } from './midtrans-CL9d1pBS.js';
const C = { class: 'space-y-6 p-5' },
  j = { class: 'border-b pb-4 text-base font-medium text-gray-900' },
  B = { class: 'px-2' },
  N = { class: 'flex justify-end space-x-3' },
  S = {
    props: { propertyModal: { type: Object, default: null } },
    data() {
      return {
        process: !1,
        loaded: !0,
        isValid: !1,
        student_quota: null,
        form: { school_year: null, name: null, is_active: null },
        field: {
          name: { label: 'Tahun Ajaran', rules: [b.isRequired('Tahun Ajaran')], error: null },
          is_active: { label: 'Status', rules: [], error: null },
        },
      };
    },
    created() {
      var e;
      this.propertyModal.data.mode == 'school-year-edit-form' &&
        (this.form.school_year = (e = this.propertyModal.data.school_year) == null ? void 0 : e.uuid);
    },
    methods: {
      submit() {
        this.$refs.schoolYearForm.validate((o) => {
          if (o) {
            this.process = !0;
            let e = JSON.parse(JSON.stringify(this.form));
            v.post(route('guardian.admissionStudent.checkout'), e, { headers: { 'Content-Type': 'application/json' } })
              .then((s) => {
                s.data.status === 'success'
                  ? (m({ title: 'Berhasil', message: s.data.message, type: 'success' }),
                    setTimeout(() => {
                      this.close(), this.$inertia.reload();
                    }, 2e3))
                  : m({ title: 'Error', message: s.data.message, type: 'error' });
              })
              .catch((s) => {
                var t, l;
                if (
                  (m({ title: 'Error', message: 'Terjadi kesalahan.', type: 'error' }),
                  (l = (t = s.response) == null ? void 0 : t.data) != null && l.errors)
                )
                  for (let a in s.response.data.errors)
                    (this.field[a].error = s.response.data.errors[a]), this.$refs.schoolYearForm.validateField(a);
              })
              .finally(() => {
                this.process = !1;
              });
          }
        });
      },
      close() {
        this.$emit('close');
      },
    },
  },
  $ = Object.assign(S, {
    __name: 'Form',
    setup(o) {
      return (
        y.init(),
        (e, s) => {
          var u;
          const t = d('el-input'),
            l = d('el-form-item'),
            a = d('el-form');
          return (
            f(),
            _('div', C, [
              n('h2', j, g((u = o.propertyModal) == null ? void 0 : u.title), 1),
              n('div', B, [
                e.loaded
                  ? (f(),
                    k(
                      a,
                      { key: 0, ref: 'schoolYearForm', 'label-position': 'top', model: e.form, disabled: e.process },
                      {
                        default: r(() => [
                          i(
                            l,
                            {
                              class: 'font-medium',
                              label: e.field.name.label,
                              rules: e.field.name.rules,
                              error: e.field.name.error,
                              prop: 'name',
                            },
                            {
                              default: r(() => [
                                i(
                                  t,
                                  {
                                    modelValue: e.form.name,
                                    'onUpdate:modelValue': s[0] || (s[0] = (h) => (e.form.name = h)),
                                    autocomplete: 'off',
                                  },
                                  null,
                                  8,
                                  ['modelValue'],
                                ),
                              ]),
                              _: 1,
                            },
                            8,
                            ['label', 'rules', 'error'],
                          ),
                        ]),
                        _: 1,
                      },
                      8,
                      ['model', 'disabled'],
                    ))
                  : V('', !0),
              ]),
              n('div', N, [
                i(
                  p,
                  { type: 'light', onClick: e.close, disabled: e.process },
                  { default: r(() => s[1] || (s[1] = [c(' Batal ')])), _: 1 },
                  8,
                  ['onClick', 'disabled'],
                ),
                i(
                  p,
                  { type: 'default', onClick: e.submit, disabled: e.process },
                  { default: r(() => s[2] || (s[2] = [c(' Simpan ')])), _: 1 },
                  8,
                  ['onClick', 'disabled'],
                ),
              ]),
            ])
          );
        }
      );
    },
  });
export { $ as default };
