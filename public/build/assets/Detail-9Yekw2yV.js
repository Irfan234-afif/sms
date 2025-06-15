import './_plugin-vue_export-helper-DlAUqK2U.js';
import { F as c, o as d, m as f, u as h, w as i, t as n, a as o, g as r, b as s, l as u } from './app-BOJ1hdTq.js';
import { _ as g } from './Breadcrumb-x1o1tzwI.js';
import { D as x } from './DefaultButton-BSKHMCln.js';
import p from './Form-DIFwY4dU.js';
import './OutlineButton-oyfjfmtZ.js';
import { a as _, _ as b } from './SchoolSidebar-CKFndFPW.js';
const y = { class: 'bg-white p-4 antialiased dark:bg-gray-900 md:p-6' },
  k = { class: 'px-4 2xl:px-0' },
  w = { class: 'text-base font-medium text-gray-900 dark:text-white md:pb-2' },
  v = { class: 'grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4' },
  M = { class: 'grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12' },
  $ = { class: 'space-y-4' },
  j = { class: 'text-xs text-gray-500 dark:text-gray-400' },
  S = { class: 'text-xs text-gray-500 dark:text-gray-400' },
  A = { class: 'text-xs text-gray-500 dark:text-gray-400' },
  B = { class: 'mb-4 border-b border-gray-200 dark:border-gray-700' },
  C = {
    class: '-mb-px flex flex-wrap text-center text-sm font-medium',
    id: 'default-tab',
    'data-tabs-toggle': '#default-tab-content',
    role: 'tablist',
  },
  D = ['id', 'data-tabs-target', 'aria-controls'],
  K = { id: 'default-tab-content', class: 'w-full' },
  O = ['id', 'aria-labelledby'],
  P = { class: 'w-full' },
  F = ['href'],
  L = {
    props: { school_classroom: Object, assessment_record: Object },
    data() {
      return {
        breadcrumbs: [
          { label: 'Sekolah', href: route('school') },
          {
            label: `Kelas (${this.school_classroom.data.title})`,
            href: route('school.learningActivity.schoolClassroom'),
          },
          {
            label: 'Penilaian Mata Pelajaran',
            href: route('school.learningActivity.schoolClassroom.assessmentSubject', {
              school_classroom_id: this.school_classroom.data.uuid,
            }),
          },
          { label: this.assessment_record.data.name, href: '#' },
        ],
        showModal: !1,
        propertyModal: { title: null, mode: null, maxWidth: null, data: null },
      };
    },
    methods: {
      openModal(t) {
        (this.showModal = !0), (this.propertyModal = t);
      },
      closeModal() {
        (this.showModal = !1), (this.propertyModal = { title: null, mode: null, maxWidth: null, data: null });
      },
    },
  },
  H = Object.assign(L, {
    __name: 'Detail',
    setup(t) {
      return (m, e) => (
        d(),
        r(
          c,
          null,
          [
            o(h(f), { title: 'Sekolah' }),
            o(_, null, {
              header: i(() => [o(g, { breadcrumbs: m.breadcrumbs }, null, 8, ['breadcrumbs'])]),
              sidebar: i(() => [o(b)]),
              content: i(() => [
                s('section', y, [
                  s('div', k, [
                    s('h1', w, n(t.assessment_record.data.name), 1),
                    s('div', v, [
                      s('div', M, [
                        s('div', $, [
                          s('dl', null, [
                            e[0] ||
                              (e[0] = s(
                                'dt',
                                { class: 'text-xs font-medium text-gray-800 dark:text-white' },
                                'Kelas',
                                -1,
                              )),
                            s('dd', j, n(t.assessment_record.data.classroom.title ?? '-'), 1),
                          ]),
                          s('dl', null, [
                            e[1] ||
                              (e[1] = s(
                                'dt',
                                { class: 'text-xs font-medium text-gray-800 dark:text-white' },
                                'Mata Pelajaran',
                                -1,
                              )),
                            s('dd', S, n(t.assessment_record.data.subject.title ?? '-'), 1),
                          ]),
                          s('dl', null, [
                            e[2] ||
                              (e[2] = s(
                                'dt',
                                { class: 'text-xs font-medium text-gray-800 dark:text-white' },
                                'Modul',
                                -1,
                              )),
                            s('dd', A, n(t.assessment_record.data.module.name ?? '-'), 1),
                          ]),
                        ]),
                      ]),
                    ]),
                    e[4] || (e[4] = s('hr', null, null, -1)),
                    s('div', B, [
                      s('ul', C, [
                        (d(!0),
                        r(
                          c,
                          null,
                          u(
                            t.assessment_record.data.module.aspects.filter((l) => l.use_sessions),
                            (l, a) => (
                              d(),
                              r('li', { key: a, class: 'me-2', role: 'presentation' }, [
                                s(
                                  'button',
                                  {
                                    class: 'inline-block rounded-t-lg border-b-2 p-4',
                                    id: `tab-${a}`,
                                    'data-tabs-target': `#tab-panel-${a}`,
                                    type: 'button',
                                    role: 'tab',
                                    'aria-controls': `tab-panel-${a}`,
                                    'aria-selected': 'false',
                                  },
                                  n(l.name),
                                  9,
                                  D,
                                ),
                              ])
                            ),
                          ),
                          128,
                        )),
                      ]),
                    ]),
                    s('div', K, [
                      (d(!0),
                      r(
                        c,
                        null,
                        u(
                          t.assessment_record.data.module.aspects.filter((l) => l.use_sessions),
                          (l, a) => (
                            d(),
                            r(
                              'div',
                              {
                                key: a,
                                class: 'hidden rounded-lg',
                                id: `tab-panel-${a}`,
                                role: 'tabpanel',
                                'aria-labelledby': `tab-${a}`,
                              },
                              [
                                s('div', P, [
                                  o(
                                    p,
                                    {
                                      assessment_record: t.assessment_record.data,
                                      assessment_aspect: l,
                                      assessment_sessions: t.assessment_record.data.sessions,
                                    },
                                    null,
                                    8,
                                    ['assessment_record', 'assessment_aspect', 'assessment_sessions'],
                                  ),
                                ]),
                              ],
                              8,
                              O,
                            )
                          ),
                        ),
                        128,
                      )),
                    ]),
                    s(
                      'a',
                      {
                        href: m.route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentStudent', {
                          assessment_record_id: t.assessment_record.data.uuid,
                          school_classroom_id: t.school_classroom.data.uuid,
                        }),
                      },
                      [
                        o(
                          x,
                          { type: 'yellow' },
                          {
                            default: i(
                              () =>
                                e[3] ||
                                (e[3] = [
                                  s(
                                    'div',
                                    { class: 'flex items-center space-x-1' },
                                    [s('div', null, 'Lakukan Penilaian')],
                                    -1,
                                  ),
                                ]),
                            ),
                            _: 1,
                          },
                        ),
                      ],
                      8,
                      F,
                    ),
                  ]),
                ]),
              ]),
              _: 1,
            }),
          ],
          64,
        )
      );
    },
  });
export { H as default };
