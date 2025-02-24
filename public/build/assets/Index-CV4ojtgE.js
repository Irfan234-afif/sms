import './_plugin-vue_export-helper-DlAUqK2U.js';
import {
  p as b,
  l as B,
  o as c,
  f as C,
  g as d,
  b as e,
  F as h,
  w as l,
  t as M,
  h as n,
  c as p,
  a as s,
  m as v,
  u as w,
} from './app-DRwuzDen.js';
import { _ as N } from './Breadcrumb-KdgMRW8V.js';
import './DefaultButton-BI1xwmx8.js';
import './fieldValidation-NAdqwKjZ.js';
import V from './Form-DmUA7RNi.js';
import { _ as x } from './ICCSidebar-DROHbre0.js';
import './midtrans-CL9d1pBS.js';
import { _ as j } from './Modal-DAZo4r06.js';
import { _ as k } from './OfficeLayout-BiGV16t7.js';
import { O as g } from './OutlineButton-2euG5CSM.js';
import { S as _, _ as y } from './Search-De_Mq1nR.js';
const $ = {
    class:
      'mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0',
  },
  O = { class: 'w-full md:w-1/3' },
  W = { class: 'relative overflow-hidden bg-white shadow-md dark:bg-gray-800' },
  S = { class: 'overflow-x-auto' },
  A = { class: 'w-full text-left text-xs text-gray-500 dark:text-gray-400' },
  T = { class: 'bg-gray-50 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-400' };
const E = { class: 'text-xs' };
const Y = { scope: 'row', class: 'whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white' },
  z = { class: 'flex items-center' },
  F = { class: 'whitespace-nowrap px-4 py-3' },
  I = { class: 'whitespace-nowrap px-4 py-3 font-medium text-gray-900 dark:text-white' },
  D = { class: 'flex items-center justify-end space-x-3' },
  H = {
    props: { search_params: Object, school_years: Object, school_years: Object },
    data() {
      return { showModal: !1, propertyModal: { title: null, mode: null, maxWidth: null, data: null } };
    },
    methods: {
      openModal(o) {
        (this.showModal = !0), (this.propertyModal = o);
      },
      closeModal() {
        (this.showModal = !1), (this.propertyModal = { title: null, mode: null, maxWidth: null, data: null });
      },
    },
  },
  te = Object.assign(H, {
    __name: 'Index',
    setup(o) {
      const f = [
        { label: 'Yayasan', href: route('office') },
        { label: 'ICC', href: route('office.icc') },
        { label: 'Tahun Ajaran', href: route('office.icc.management.schoolYear') },
      ];
      return (r, a) => {
        const u = b('Badge');
        return (
          c(),
          d(
            h,
            null,
            [
              s(w(v), { title: 'Yayasan' }),
              s(k, null, {
                header: l(() => [
                  s(N, { breadcrumbs: f }),
                  e('div', $, [e('div', O, [s(_, { search_params: o.search_params }, null, 8, ['search_params'])])]),
                ]),
                sidebar: l(() => [s(x)]),
                content: l(() => {
                  var i;
                  return [
                    e('section', null, [
                      e('div', W, [
                        e('div', S, [
                          e('table', A, [
                            e('thead', T, [
                              e('tr', null, [
                                n('', !0),
                                a[2] || (a[2] = e('th', { scope: 'col', class: 'p-4' }, 'Tahun Ajaran', -1)),
                                a[3] || (a[3] = e('th', { scope: 'col', class: 'p-4' }, 'Status', -1)),
                                a[4] || (a[4] = e('th', { scope: 'col', class: 'p-4' }, null, -1)),
                              ]),
                            ]),
                            e('tbody', E, [
                              (c(!0),
                              d(
                                h,
                                null,
                                B(
                                  o.school_years.data,
                                  (t, m) => (
                                    c(),
                                    d(
                                      'tr',
                                      {
                                        key: m,
                                        class: 'border-b hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-700',
                                      },
                                      [
                                        n('', !0),
                                        e('th', Y, [e('div', z, M(t.name), 1)]),
                                        e('td', F, [
                                          t.is_active
                                            ? (c(),
                                              p(
                                                u,
                                                { key: 0, type: 'green' },
                                                { default: l(() => a[6] || (a[6] = [C('Aktif')])), _: 1 },
                                              ))
                                            : n('', !0),
                                        ]),
                                        e('td', I, [
                                          e('div', D, [
                                            s(
                                              g,
                                              {
                                                type: 'default',
                                                onClick: (L) =>
                                                  r.openModal({
                                                    title: 'Tahun Ajaran',
                                                    mode: 'school-year-edit-form',
                                                    maxWidth: '2xl',
                                                    data: { school_year: t },
                                                  }),
                                              },
                                              {
                                                default: l(
                                                  () =>
                                                    a[7] ||
                                                    (a[7] = [
                                                      e(
                                                        'div',
                                                        { class: 'flex items-center space-x-1' },
                                                        [
                                                          e(
                                                            'svg',
                                                            {
                                                              xmlns: 'http://www.w3.org/2000/svg',
                                                              viewBox: '0 0 24 24',
                                                              fill: 'none',
                                                              stroke: 'currentColor',
                                                              'stroke-width': '1.5',
                                                              'stroke-linecap': 'round',
                                                              'stroke-linejoin': 'round',
                                                              class: 'h-4',
                                                            },
                                                            [
                                                              e('path', {
                                                                stroke: 'none',
                                                                d: 'M0 0h24v24H0z',
                                                                fill: 'none',
                                                              }),
                                                              e('path', {
                                                                d: 'M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1',
                                                              }),
                                                              e('path', {
                                                                d: 'M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z',
                                                              }),
                                                              e('path', { d: 'M16 5l3 3' }),
                                                            ],
                                                          ),
                                                          e('div', null, 'Sunting'),
                                                        ],
                                                        -1,
                                                      ),
                                                    ]),
                                                ),
                                                _: 2,
                                              },
                                              1032,
                                              ['onClick'],
                                            ),
                                          ]),
                                        ]),
                                      ],
                                    )
                                  ),
                                ),
                                128,
                              )),
                            ]),
                          ]),
                        ]),
                        s(
                          y,
                          { search_params: o.search_params, meta: o.school_years.meta, links: o.school_years.links },
                          null,
                          8,
                          ['search_params', 'meta', 'links'],
                        ),
                      ]),
                    ]),
                    s(
                      j,
                      {
                        show: r.showModal,
                        property: r.propertyModal,
                        maxWidth: (i = r.propertyModal) == null ? void 0 : i.maxWidth,
                        onClose: r.closeModal,
                      },
                      {
                        default: l(({ propertyModal: t }) => [
                          (t == null ? void 0 : t.mode) == 'school-year-edit-form'
                            ? (c(),
                              p(
                                V,
                                { key: 0, propertyModal: t, onClose: a[0] || (a[0] = (m) => r.closeModal()) },
                                null,
                                8,
                                ['propertyModal'],
                              ))
                            : n('', !0),
                        ]),
                        _: 1,
                      },
                      8,
                      ['show', 'property', 'maxWidth', 'onClose'],
                    ),
                  ];
                }),
                _: 1,
              }),
            ],
            64,
          )
        );
      };
    },
  });
export { te as default };
