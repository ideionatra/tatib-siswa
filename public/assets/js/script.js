'use strict';

document.addEventListener('DOMContentLoaded', function () {
    initializeSidebar();
    initializeDeleteConfirmation();
    initializeReportForm();
});

function initializeSidebar() {
    const sidebar = document.getElementById('sidebar');
    const toggle = document.getElementById('menuToggle');
    const overlay = document.getElementById('sidebarOverlay');

    if (!sidebar || !toggle || !overlay) {
        return;
    }

    function closeSidebar() {
        sidebar.classList.remove('open');
        overlay.classList.remove('visible');
    }

    toggle.addEventListener('click', function () {
        sidebar.classList.toggle('open');
        overlay.classList.toggle('visible');
    });

    overlay.addEventListener('click', closeSidebar);

    window.addEventListener('resize', function () {
        if (window.innerWidth > 900) {
            closeSidebar();
        }
    });
}

function initializeDeleteConfirmation() {
    const forms = document.querySelectorAll('form[data-confirm]');

    forms.forEach(function (form) {
        form.addEventListener('submit', function (event) {
            const message = form.dataset.confirm || 'Hapus data ini?';

            if (!window.confirm(message)) {
                event.preventDefault();
            }
        });
    });
}

function initializeReportForm() {
    const form = document.getElementById('reportForm');
    const studentDataElement = document.getElementById('studentData');

    if (!form || !studentDataElement) {
        return;
    }

    const classSelect = document.getElementById('reportClass');
    const studentSelect = document.getElementById('reportStudent');

    const violationCategory = document.getElementById(
        'violationCategory'
    );

    const achievementCategory = document.getElementById(
        'achievementCategory'
    );

    const violationSelect = document.getElementById(
        'violationSelect'
    );

    const achievementSelect = document.getElementById(
        'achievementSelect'
    );

    const sanctionInput = document.getElementById('sanksi');

    let students = [];

    try {
        students = JSON.parse(studentDataElement.textContent);
    } catch (error) {
        students = [];
    }

    function updateStudents() {
        const classId = Number(classSelect.value);
        const selectedId = Number(studentSelect.dataset.selected || 0);

        studentSelect.innerHTML = '';

        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.textContent = 'Pilih siswa';

        studentSelect.appendChild(defaultOption);

        students
            .filter(function (student) {
                return Number(student.id_kelas) === classId;
            })
            .forEach(function (student) {
                const option = document.createElement('option');

                option.value = student.id;
                option.textContent = student.nama + ' - ' + student.nis;

                if (Number(student.id) === selectedId) {
                    option.selected = true;
                }

                studentSelect.appendChild(option);
            });

        studentSelect.dataset.selected = '';
    }

    function updateReportType() {
        const selectedType = form.querySelector(
            'input[name="jenis_laporan"]:checked'
        );

        const type = selectedType ? selectedType.value : 'pelanggaran';
        const isViolation = type === 'pelanggaran';

        violationCategory.hidden = !isViolation;
        achievementCategory.hidden = isViolation;

        violationSelect.disabled = !isViolation;
        achievementSelect.disabled = isViolation;

        violationSelect.required = isViolation;
        achievementSelect.required = !isViolation;

        sanctionInput.disabled = !isViolation;
        sanctionInput.required = isViolation;

        if (!isViolation) {
            sanctionInput.value = '';
        }
    }

    classSelect.addEventListener('change', updateStudents);

    form
        .querySelectorAll('input[name="jenis_laporan"]')
        .forEach(function (radio) {
            radio.addEventListener('change', updateReportType);
        });

    updateStudents();
    updateReportType();
}